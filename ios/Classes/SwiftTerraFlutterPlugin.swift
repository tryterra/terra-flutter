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
  // permission type translate
  private func permissionParse(permission: String) -> Permissions? {
      switch permission {
          case "ACTIVITY":
              return Permissions.ACTIVITY
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
      return nil
  }

  // test function
  private func testFunction(args: [String: Any], result: @escaping FlutterResult){
    result("Test function working in iOS, you passed text: " + (args["text"] as! String))
  }

  // permissions array to permissions set
  private func permissionsSet(permissions: [String]) -> Set<Permissions> {
    var out: Set<Permissions> = Set([])
    for permission in permissions {
		if let p = permissionParse(permission: permission) {
			out.insert(p)
		}
    }
    return out
  }

  // custom permissions to object
  private func customPermissionParse(cPermission: String) -> Set<HKObjectType> {
        switch cPermission {
            case "WORKOUT_TYPES":
                return Set([HKObjectType.workoutType()])
            case "ACTIVITY_SUMMARY":
                return Set([HKObjectType.activitySummaryType()])
            case "LOCATION":
                return Set([HKSeriesType.workoutRoute()])
            case "CALORIES":
                return Set([HKObjectType.quantityType(forIdentifier:.activeEnergyBurned)!])
            case "STEPS":
                return Set([HKQuantityType.quantityType(forIdentifier: .stepCount)!])
            case "HEART_RATE":
                return Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])
            case "HEART_RATE_VARIABILITY":
                return Set([HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!])
            case "VO2MAX":
                return Set([HKObjectType.quantityType(forIdentifier: .vo2Max)!])
            case "HEIGHT":
                return Set([HKObjectType.quantityType(forIdentifier: .height)!])
            case "ACTIVE_DURATIONS":
                return Set([HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!])
            case "WEIGHT":
                return Set([HKObjectType.quantityType(forIdentifier: .bodyMass)!])
            case "FLIGHTS_CLIMBED":
                return Set([HKObjectType.quantityType(forIdentifier: .flightsClimbed)!])
            case "BMI":
                return Set([HKObjectType.quantityType(forIdentifier: .bodyMassIndex)!])
            case "BODY_FAT":
                return Set([HKObjectType.quantityType(forIdentifier: .bodyFatPercentage)!])
            case "EXERCISE_DISTANCE":
                return Set([HKObjectType.quantityType(forIdentifier: .distanceSwimming)!, HKObjectType.quantityType(forIdentifier: .distanceCycling)!, HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!])
            case "GENDER":
                return Set([HKObjectType.characteristicType(forIdentifier: .biologicalSex)!])
            case "DATE_OF_BIRTH":
                return Set([HKObjectType.characteristicType(forIdentifier: .dateOfBirth)!])
            case "BASAL_ENERGY_BURNED":
                return Set([HKObjectType.quantityType(forIdentifier: .basalEnergyBurned)!])
            case "SWIMMING_SUMMARY":
                return Set([HKObjectType.quantityType(forIdentifier: .swimmingStrokeCount)!])
            case "RESTING_HEART_RATE":
                return Set([HKObjectType.quantityType(forIdentifier: .restingHeartRate)!])
            case "BLOOD_PRESSURE":
                return Set([HKObjectType.quantityType(forIdentifier: .bloodPressureDiastolic)!, HKObjectType.quantityType(forIdentifier: .bloodPressureSystolic)!])
            case "BLOOD_GLUCOSE":
                return Set([HKObjectType.quantityType(forIdentifier: .bloodGlucose)!])
            case "BODY_TEMPERATURE":
                return Set([HKObjectType.quantityType(forIdentifier: .bodyTemperature)!])
            case "LEAN_BODY_MASS":
                return Set([HKObjectType.quantityType(forIdentifier: .leanBodyMass)!])
            case "OXYGEN_SATURATION":
                return Set([HKObjectType.quantityType(forIdentifier: .oxygenSaturation)!])
            case "SLEEP_ANALYSIS":
                return Set([HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!])
            case "RESPIRATORY_RATE":
                return Set([HKObjectType.quantityType(forIdentifier: .respiratoryRate)!])
            case "NUTRITION_SODIUM":
                return Set([HKObjectType.quantityType(forIdentifier: .dietarySodium)!])
            case "NUTRITION_PROTEIN":
                return Set([HKObjectType.quantityType(forIdentifier: .dietaryProtein)!])
            case "NUTRITION_CARBOHYDRATES":
                return Set([HKObjectType.quantityType(forIdentifier: .dietaryCarbohydrates)!])
            case "NUTRITION_FIBRE":
                return Set([HKObjectType.quantityType(forIdentifier: .dietaryFiber)!])
            case "NUTRITION_FAT_TOTAL":
                return Set([HKObjectType.quantityType(forIdentifier: .dietaryFatTotal)!])
            case "NUTRITION_SUGAR":
                return Set([HKObjectType.quantityType(forIdentifier: .dietarySugar)!])
            case "NUTRITION_VITAMIN_C":
                return Set([HKObjectType.quantityType(forIdentifier: .dietaryVitaminC)!])
            case "NUTRITION_VITAMIN_A":
                return Set([HKObjectType.quantityType(forIdentifier: .dietaryVitaminA)!])
            case "NUTRITION_CALORIES":
                return Set([HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!])
            case "NUTRITION_WATER":
                return Set([HKObjectType.quantityType(forIdentifier: .dietaryWater)!])
            case "NUTRITION_CHOLESTEROL":
                return Set([HKObjectType.quantityType(forIdentifier: .dietaryCholesterol)!])
            default:
                return Set([])
        }
        return Set([])
    }

	private func customPermissionsSet(customPermissions: [String]) -> Set<HKObjectType> {
        var out: Set<HKObjectType> = Set([])

        for permission in customPermissions {
            out.formUnion(customPermissionParse(cPermission: permission))
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
			){(success: Bool, data: [TerraBodyData]?) in result(success)}
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
			){(success: Bool, data: [TerraActivityData]?) in result(success)}
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
			){(success: Bool, data: TerraAthleteData?) in result(success)}
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
			){(success: Bool, data: [TerraDailyData]?) in result(success)}
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
			){(success: Bool, data: [TerraNutritionData]?) in result(success)}
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
			){(success: Bool, data: [TerraSleepData]?) in result(success)}
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
