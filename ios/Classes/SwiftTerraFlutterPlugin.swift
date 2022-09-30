import Flutter
import UIKit
import TerraiOS
import Foundation
import HealthKit

public class SwiftTerraFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "terra_flutter_bridge", binaryMessenger: registrar.messenger())
    let instance = SwiftTerraFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  // terra instance managed
  private var terra: Terra?
  
  // connection type translate
  private func connectionParse(connection: String) -> Connections? {
		switch connection {
			case "APPLE_HEALTH":
				return Connections.APPLE_HEALTH
			case "FREESTYLE_LIBRE":
				return Connections.FREESTYLE_LIBRE
			default:
				print("Passed invalid connection")
		}
    	return nil
  }

  // test function
  private func testFunction(args: [String: Any], result: @escaping FlutterResult){
    result("Test function working in iOS, you passed text: " + (args["text"] as! String))
  }


  // custom permissions to object
  private func customPermissionParse(cPermission: String) -> CustomPermissions? {
        switch cPermission {
            case "WORKOUT_TYPES":
                return CustomPermissions.WORKOUT_TYPE;
            case "ACTIVITY_SUMMARY":
                return CustomPermissions.ACTIVITY_SUMMARY;
            case "LOCATION":
                return CustomPermissions.LOCATION;
            case "CALORIES":
                return CustomPermissions.CALORIES;
            case "STEPS":
                return CustomPermissions.STEPS;
            case "HEART_RATE":
                return CustomPermissions.HEART_RATE;
            case "HEART_RATE_VARIABILITY":
                return CustomPermissions.HEART_RATE_VARIABILITY;
            case "VO2MAX":
                return CustomPermissions.VO2MAX;
            case "HEIGHT":
                return CustomPermissions.HEIGHT;
            case "ACTIVE_DURATIONS":
                return CustomPermissions.ACTIVE_DURATIONS;
            case "WEIGHT":
                return CustomPermissions.WEIGHT;
            case "FLIGHTS_CLIMBED":
                return CustomPermissions.FLIGHTS_CLIMBED;
            case "BMI":
                return CustomPermissions.BMI;
            case "BODY_FAT":
                return CustomPermissions.BODY_FAT;
            case "EXERCISE_DISTANCE":
                return CustomPermissions.EXERCISE_DISTANCE;
            case "GENDER":
                return CustomPermissions.GENDER;
            case "DATE_OF_BIRTH":
                return CustomPermissions.DATE_OF_BIRTH;
            case "BASAL_ENERGY_BURNED":
                return CustomPermissions.BASAL_ENERGY_BURNED;
            case "SWIMMING_SUMMARY":
                return CustomPermissions.SWIMMING_SUMMARY;
            case "RESTING_HEART_RATE":
                return CustomPermissions.RESTING_HEART_RATE;
            case "BLOOD_PRESSURE":
                return CustomPermissions.BLOOD_PRESSURE;
            case "BLOOD_GLUCOSE":
                return CustomPermissions.BLOOD_GLUCOSE;
            case "BODY_TEMPERATURE":
                return CustomPermissions.BODY_TEMPERATURE;
            case "MINDFULNESS":
                return CustomPermissions.MINDFULNESS;
            case "LEAN_BODY_MASS":
                return CustomPermissions.LEAN_BODY_MASS;
            case "OXYGEN_SATURATION":
                return CustomPermissions.OXYGEN_SATURATION;
            case "SLEEP_ANALYSIS":
                return CustomPermissions.SLEEP_ANALYSIS;
            case "RESPIRATORY_RATE":
                return CustomPermissions.RESPIRATORY_RATE;
            case "NUTRITION_SODIUM":
                return CustomPermissions.NUTRITION_SODIUM;
            case "NUTRITION_PROTEIN":
                return CustomPermissions.NUTRITION_PROTEIN;
            case "NUTRITION_CARBOHYDRATES":
                return CustomPermissions.NUTRITION_CARBOHYDRATES;
            case "NUTRITION_FIBRE":
                return CustomPermissions.NUTRITION_FIBRE;
            case "NUTRITION_FAT_TOTAL":
                return CustomPermissions.NUTRITION_FAT_TOTAL;
            case "NUTRITION_SUGAR":
                return CustomPermissions.NUTRITION_SUGAR;
            case "NUTRITION_VITAMIN_C":
                return CustomPermissions.NUTRITION_VITAMIN_C;
            case "NUTRITION_VITAMIN_A":
                return CustomPermissions.NUTRITION_VITAMIN_A;
            case "NUTRITION_CALORIES":
                return CustomPermissions.NUTRITION_CALORIES;
            case "NUTRITION_WATER":
                return CustomPermissions.NUTRITION_WATER;
            case "NUTRITION_CHOLESTEROL":
                return CustomPermissions.NUTRITION_CHOLESTEROL;
            case "MENSTRUATION":
                return CustomPermissions.MENSTRUATION;
            default:
                return nil
        }
        return nil
    }

	private func customPermissionsSet(customPermissions: [String]) -> Set<CustomPermissions> {
        var out: Set<CustomPermissions> = Set([])

        for permission in customPermissions {
            if let perm = customPermissionParse(cPermission: permission){
                out.insert(perm)
            }
        }

        return out
    }

	// initialize
	private func initTerra(
		devID: String,
		referenceId: String,
		result: @escaping FlutterResult
	){
		terra = Terra(
			devId: devID,
            referenceId: referenceId){success in
                result(success)
        }
	}

	private func initConnection(
		connection: String,
		token: String,
		schedulerOn: Bool,
		customPermissions: [String],
		result: @escaping FlutterResult
	){
		let c = connectionParse(connection: connection)
		if c != nil && terra != nil{
			terra!.initConnection(
				type: c!,
				token: token,
				customReadTypes: customPermissionsSet(customPermissions: customPermissions),
				schedulerOn: schedulerOn
			){(success: Bool) in result(success)}
		}
		else {
			result(FlutterError(
				code: "error",
				message: "could not initialise connection",
				details: nil
			))
		}
	}

	private func getUserId(
		connection: String,
		result: @escaping FlutterResult
	) {
		let c = connectionParse(connection: connection)
		if c != nil && terra != nil {
			result(terra!.getUserId(type: c!))
		} else {
			result(FlutterError(
				code: "Connection Type Error",
				message: "Could not call getter for type: body. make sure you are passing a valid iOS connection and that terra is initialised by calling initTerra",
				details: nil
			))
		}
	}

	// getters
	private func getBody(
		connection: String,
		startDate: Date,
		endDate: Date,
		result: @escaping FlutterResult
	) {
		let c = connectionParse(connection: connection)
		if c != nil && terra != nil {
			terra!.getBody(
				type: c!,
				startDate: startDate,
				endDate: endDate
			){(success: Bool) in result(success)}
		} else {
			result(FlutterError(
				code: "Connection Type Error",
				message: "Could not call getter for type: body. make sure you are passing a valid iOS connection and that terra is initialised by calling initTerra",
				details: nil
			))
		}
	}
	private func getActivity(
		connection: String,
		startDate: Date,
		endDate: Date,
		result: @escaping FlutterResult
	) {
		let c = connectionParse(connection: connection)
		if c != nil && terra != nil {
			terra!.getActivity(
				type: c!,
				startDate: startDate,
				endDate: endDate
			){(success: Bool) in result(success)}
		} else {
			result(FlutterError(
				code: "Connection Type Error",
				message: "Could not call getter for type: activity. make sure you are passing a valid iOS connection and that terra is initialised by calling initTerra",
				details: nil
			))
		}
	}

	private func getMenstruation(
		connection: String,
		startDate: Date,
		endDate: Date,
		result: @escaping FlutterResult
	) {
		let c = connectionParse(connection: connection)
		if c != nil && terra != nil {
			terra!.getMenstruation(
				type: c!,
				startDate: startDate,
				endDate: endDate
			){(success: Bool) in result(success)}
		} else {
			result(FlutterError(
				code: "Connection Type Error",
				message: "Could not call getter for type: activity. make sure you are passing a valid iOS connection and that terra is initialised by calling initTerra",
				details: nil
			))
		}
	}

	private func getAthlete(connection: String, result: @escaping FlutterResult){
		let c = connectionParse(connection: connection)
		if c != nil && terra != nil {
			terra!.getAthlete(
				type: c!
			){(success: Bool) in result(success)}
		} else {
			result(FlutterError(
				code: "Connection Type Error",
				message: "Could not call getter for type: athlete. make sure you are passing a valid iOS connection and that terra is initialised by calling initTerra",
				details: nil
			))
		}
	}
	private func getDaily(
		connection: String,
		startDate: Date,
		endDate: Date,
		result: @escaping FlutterResult
	) {
		let c = connectionParse(connection: connection)
		if c != nil && terra != nil {
			terra!.getDaily(
				type: c!,
				startDate: startDate,
				endDate: endDate
			){(success: Bool) in result(success)}
		} else {
			result(FlutterError(
				code: "Connection Type Error",
				message: "Could not call getter for type: daily. make sure you are passing a valid iOS connection and that terra is initialised by calling initTerra",
				details: nil
			))
		}
	}
	private func getNutrition(
		connection: String,
		startDate: Date,
		endDate: Date,
		result: @escaping FlutterResult
	) {
		let c = connectionParse(connection: connection)
		if c != nil && terra != nil {
			terra!.getNutrition(
				type: c!,
				startDate: startDate,
				endDate: endDate
			){(success: Bool) in result(success)}
		} else {
			result(FlutterError(
				code: "Connection Type Error",
				message: "Could not call getter for type: nutrition. make sure you are passing a valid iOS connection and that terra is initialised by calling initTerra",
				details: nil
			))
		}
	}
	private func getSleep(
		connection: String,
		startDate: Date,
		endDate: Date,
		result: @escaping FlutterResult
	) {
		let c = connectionParse(connection: connection)
		if c != nil && terra != nil {
			terra!.getSleep(
				type: c!,
				startDate: startDate,
				endDate: endDate
			){(success: Bool) in result(success)}
		} else {
			result(FlutterError(
				code: "Connection Type Error",
				message: "Could not call getter for type: sleep. make sure you are passing a valid iOS connection and that terra is initialised by calling initTerra",
				details: nil
			))
		}
	}

	// Freestyle
	func readGlucoseData(result: @escaping FlutterResult){
		 terra?.readGlucoseData{(details) in
            do {
                let jsonData = try JSONEncoder().encode(details)
                result(String(data: jsonData, encoding: .utf8) ?? "")
            }
            catch {
                result(nil)
            }
        }
	}

	func activateGlucoseSensor(result: @escaping FlutterResult){
		do {
            try terra?.activateSensor()
            result(true)
        }
        catch {
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
						referenceId: args["referenceID"] as! String,
						result: result
					)
					break;
				case "getUserId":
					getUserId(
						connection: args["connection"] as! String,
						result: result
					)
				case "initConnection":
					initConnection(
						connection: args["connection"] as! String,
						token: args["token"] as! String,
						schedulerOn: args["schedulerOn"] as! Bool,
						customPermissions: args["customPermissions"] as! [String],
						result: result
					)
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
				case "getMenstruation":
					getMenstruation(
						connection: args["connection"] as! String,
						startDate: dateFormatter.date(from: args["startDate"] as! String)!,
						endDate: dateFormatter.date(from: args["endDate"] as! String)!,
						result: result
					)
					break;
				case "readGlucoseData":
					readGlucoseData(result: result)
					break;
				case "activateGlucoseSensor":
					activateGlucoseSensor(result: result)
					break;
				default:
					result(FlutterMethodNotImplemented)
		}
	}
}
