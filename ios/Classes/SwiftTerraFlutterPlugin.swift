import Flutter
import UIKit
import TerraiOS
import Foundation

public class SwiftTerraFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "terra_flutter_bridge", binaryMessenger: registrar.messenger())
    let instance = SwiftTerraFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  // terra instance managed
  private var terra: Terra?
  
  // connection type translate
  private func connectionParse(connection: String) -> Connections {
      switch connection {
          case "APPLE_HEALTH":
              return Connections.APPLE_HEALTH
          case "FREESTYLE_LIBRE":
              return Connections.FREESTYLE_LIBRE
          default:
              print("Passed invalid connection")
      }
    return Connections.APPLE_HEALTH
  }
  // permission type translate
  private func permissionParse(permission: String) -> Permissions {
      switch permission {
          case "ACTIVITY":
              return Permissions.ACTIVITY
          case "ATHLETE":
              return Permissions.ATHLETE
          case "BODY":
              return Permissions.BODY
          case "DAILY":
              return Permissions.DAILY
          case "NUTRITION":
              return Permissions.NUTRITION
          case "SLEEP":
              return Permissions.SLEEP
          default:
              print("Passed invalid permission")
      }
      return Permissions.ACTIVITY
  }

  // test function
  private func testFunction(args: [String: Any], result: @escaping FlutterResult){
    result("Test function working in iOS, you passed text: " + (args["text"] as! String))
  }

  // connection array to connection set
  private func connectionsSet(connections: [String]) -> Set<Connections> {
    var out: Set<Connections> = Set([])
    for connection in connections {
      out.insert(connectionParse(connection: connection))
    }
    return out
  }

  // permissions array to permissions set
  private func permissionsSet(permissions: [String]) -> Set<Permissions> {
    var out: Set<Permissions> = Set([])
    for permission in permissions {
      out.insert(permissionParse(permission: permission))
    }
    return out
  }

  // initialize
  private func initTerra(
    devID: String,
    apiKey: String,
    referenceId: String,
    intervalMinutes: Int,
    connectionsStr: [String],
    permissionsStr: [String],
    result: @escaping FlutterResult){
    do {
        terra = try Terra(
			devId: devID,
			xAPIKey: apiKey,
			referenceId: referenceId,
			bodySleepDailyInterval: 60,
			connections: connectionsSet(connections: connectionsStr),
			permissions: permissionsSet(permissions: permissionsStr)
			// TODO add HKTypes
                ){(success: Bool) in result(success)}
    } catch {
        result(FlutterError(code: "error", message: "could not initialise SDK", details: nil))
    }
  }

  // check auth
  private func checkAuth(connection: String, result: @escaping FlutterResult) {
    result(terra?.checkAuthentication(connection: connectionParse(connection: connection)))
  }

	// getters
	private func getBody(connection: String, startDate: Date, endDate: Date, result: @escaping FlutterResult) {
		terra?.getBody(
			type: connectionParse(connection: connection),
			startDate: startDate,
			endDate: endDate
		){(success: Bool, data: [TerraBodyData]?) in result(success)}
	}
	private func getActivity(connection: String, startDate: Date, endDate: Date, result: @escaping FlutterResult){
		terra?.getActivity(
			type: connectionParse(connection: connection),
			startDate: startDate,
			endDate: endDate
		){(success: Bool, data: [TerraActivityData]?) in result(success)}
	}
	private func getAthlete(connection: String, result: @escaping FlutterResult){
		terra?.getAthlete(
			type: connectionParse(connection: connection)
		){(success: Bool, data: TerraAthleteData?) in result(success)}
	}
	private func getDaily(connection: String, startDate: Date, endDate: Date, result: @escaping FlutterResult){
		terra?.getDaily(
			type: connectionParse(connection: connection),
			startDate: startDate,
			endDate: endDate
		){(success: Bool, data: [TerraDailyData]?) in result(success)}
	}
	private func getNutrition(connection: String, startDate: Date, endDate: Date, result: @escaping FlutterResult){
		terra?.getNutrition(
			type: connectionParse(connection: connection),
			startDate: startDate,
			endDate: endDate
		){(success: Bool, data: [TerraNutritionData]?) in result(success)}
	}
	private func getSleep(connection: String, startDate: Date, endDate: Date, result: @escaping FlutterResult){
		terra?.getSleep(
			type: connectionParse(connection: connection),
			startDate: startDate,
			endDate: endDate
		){(success: Bool, data: [TerraSleepData]?) in result(success)}
	}

	// Freestyle glucose init
	func readGlucoseData(result: @escaping FlutterResult){
		do {
			try terra?.readGlucoseData()
			result(true)
		} catch {
			result(false)
		}
	}
	
	// deauth
	func deauth(connection: String, result: @escaping FlutterResult){
		do {
			try terra?.disconnectTerra(type: connectionParse(connection: connection))
			result(true)
		} catch {
			result(false)
		}
	}

  // exposed handler
  // parse arguments and call appropriate function
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      let dateFormatter = ISO8601DateFormatter()
      dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
      guard let args_op = call.arguments else {
          result("ERROR")
          return
      }
      let args = args_op as! [String: Any]
      switch call.method {
			case "testFunction":
					testFunction(args: args, result: result)
			break;
			case "initTerra":
				initTerra(
					devID: args["devID"] as! String,
					apiKey: args["apiKey"] as! String,
					referenceId: args["referenceID"] as! String,
					intervalMinutes: args["intervalMinutes"] as! Int,
					connectionsStr: args["connections"] as! [String],
					permissionsStr: args["permissions"] as! [String],
					result: result
				)
			break;
			case "checkAuth":
				checkAuth(
					connection: args["connection"] as! String,
					result: result
				)
			break;
			case "getBody":
				getBody(
					connection: args["connection"] as! String,
					startDate: dateFormatter.date(from: args["startDate"] as! String)!,
					endDate: dateFormatter.date(from: args["endDate"] as! String)!,
					result: result
				)
			break;
			case "getDaily":
				getDaily(
					connection: args["connection"] as! String,
					startDate: dateFormatter.date(from: args["startDate"] as! String)!,
					endDate: dateFormatter.date(from: args["endDate"] as! String)!,
					result: result
				)
			break;
			case "getNutrition":
				getNutrition(
					connection: args["connection"] as! String,
					startDate: dateFormatter.date(from: args["startDate"] as! String)!,
					endDate: dateFormatter.date(from: args["endDate"] as! String)!,
					result: result
				)
			break;
			case "getAthlete":
				getAthlete(
					connection: args["connection"] as! String,
					result: result
				)
			break;
			case "getSleep":
				getSleep(
					connection: args["connection"] as! String,
					startDate: dateFormatter.date(from: args["startDate"] as! String)!,
					endDate: dateFormatter.date(from: args["endDate"] as! String)!,
					result: result
				)
			break;
			case "getActivity":
				getActivity(
					connection: args["connection"] as! String,
					startDate: dateFormatter.date(from: args["startDate"] as! String)!,
					endDate: dateFormatter.date(from: args["endDate"] as! String)!,
					result: result
				)
			break;
			case "deauth":
				deauth(
					connection: args["connection"] as! String,
					result: result
				)
				break;
			case "readGlucoseData":
				readGlucoseData(result: result)
				break;
			default:
				result(FlutterMethodNotImplemented)
    }
  }
}
