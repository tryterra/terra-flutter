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
  private var terra: TerraManager?
  
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

  private func errorMessage(_ err: TerraError) -> String{
        switch(err){
            case .HealthKitUnavailable: return "Health Kit Unavailable"
            case .ServiceUnavailable: return "Service Unavailable"
            case .Unauthenticated: return "Unauthenticated"
            case .InvalidUserID: return "Invalid User ID"
            case .InvalidDevID: return "Invalid Dev ID"
            case .Forbidden: return "Forbidden"
            case .BadRequest: return "Bad Request"
            case .UnknownOpcode: return "Unknown Op Code"
            case .UnexpectedError: return "Unexpected Error"
            case .NFCError: return "NFC Error"
            case .SensorExpired: return "Sensor Expired"
            case .SensorReadingFailed: return "Sensor Reading Failed"
            case .NoInternet: return "No Internet"
            case .UserLimitsReached: return "User Limit Reached"
            case .IncorrectDevId: return "Incorrect Dev ID"
            case .InvalidToken: return "Invalid Token"
            case .HealthKitAuthorizationError: return "Health Kit Authorization Error"
            case .UnsupportedResource: return "Unsupported Resource"
            default: "Unknown Error Type. Please contact dev@tryterra.co"
        }
        return ""
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
						case "SPEED":
								return CustomPermissions.SPEED;
						case "POWER":
								return CustomPermissions.POWER;
						case "ELECTROCARDIOGRAM":
								return CustomPermissions.ELECTROCARDIOGRAM;
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
		Terra.instance(devId: devID, referenceId: referenceId){instance, error in
            if let error = error{
                result(["success": false, "error": self.errorMessage(error)])
            }
            else{
                self.terra = instance
                result(["success": true])
            }
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
				schedulerOn: schedulerOn,
				completion: {success, error in
                    if let error = error{
                        result(["success": success, "error": self.errorMessage(error)])
                    }
                    else{
                        result(["success": success])
                    }
				}
			)
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
            result(["success": true, "userId": terra?.getUserId(type: c!)])
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
		toWebhook: Bool,
		result: @escaping FlutterResult
	) {
		let c = connectionParse(connection: connection)
		if c != nil && terra != nil {
			terra!.getBody(
				type: c!,
				startDate: startDate,
				endDate: endDate,
				toWebhook: toWebhook
			){
				(success, data, err) in 
                if let err = err {
                    result(["success": false, "data": nil, "error": self.errorMessage(err)])
                }
                else{
                    do {
                        let jsonData = try JSONEncoder().encode(data)
                        result(["success": success, "data": String(data: jsonData, encoding: .utf8) ?? ""])
                    }
                    catch {
                        result(["success": success, "error": "Error decoding data into correct format"])
                    }
                }
			}
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
		toWebhook: Bool,
		result: @escaping FlutterResult
	) {
		let c = connectionParse(connection: connection)
		if c != nil && terra != nil {
			terra!.getActivity(
				type: c!,
				startDate: startDate,
				endDate: endDate,
				toWebhook: toWebhook
			){
				(success, data, err) in 
                if let err = err {
                    result(["success": false, "data": nil, "error": self.errorMessage(err)])
                }
                else{
                    do {
                        let jsonData = try JSONEncoder().encode(data)
                        result(["success": success, "data": String(data: jsonData, encoding: .utf8) ?? ""])
                    }
                    catch {
                        result(["success": success, "error": "Error decoding data into correct format"])
                    }
                }
			}
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
		toWebhook: Bool,
		result: @escaping FlutterResult
	) {
		let c = connectionParse(connection: connection)
		if c != nil && terra != nil {
			terra!.getMenstruation(
				type: c!,
				startDate: startDate,
				endDate: endDate,
				toWebhook: toWebhook
			){
				(success, data, err) in 
                if let err = err {
                    result(["success": false, "data": nil, "error": self.errorMessage(err)])
                }
                else{
                    do {
                        let jsonData = try JSONEncoder().encode(data)
                        result(["success": success, "data": String(data: jsonData, encoding: .utf8) ?? ""])
                    }
                    catch {
                        result(["success": success, "error": "Error decoding data into correct format"])
                    }
                }
			}
		} else {
			result(FlutterError(
				code: "Connection Type Error",
				message: "Could not call getter for type: activity. make sure you are passing a valid iOS connection and that terra is initialised by calling initTerra",
				details: nil
			))
		}
	}

	private func getAthlete(connection: String, toWebhook: Bool, result: @escaping FlutterResult){
		let c = connectionParse(connection: connection)
		if c != nil && terra != nil {
			terra!.getAthlete(
				type: c!,
				toWebhook: toWebhook
			){
				(success, data, err) in 
                if let err = err {
                    result(["success": false, "data": nil, "error": self.errorMessage(err)])
                }
                else{
                    do {
                        let jsonData = try JSONEncoder().encode(data)
                        result(["success": success, "data": String(data: jsonData, encoding: .utf8) ?? ""])
                    }
                    catch {
                        result(["success": success, "error": "Error decoding data into correct format"])
                    }
                }
			}
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
		toWebhook: Bool,
		result: @escaping FlutterResult
	) {
		let c = connectionParse(connection: connection)
		if c != nil && terra != nil {
			terra!.getDaily(
				type: c!,
				startDate: startDate,
				endDate: endDate,
				toWebhook: toWebhook
			){
				(success, data, err) in 
                if let err = err {
                    result(["success": false, "data": nil, "error": self.errorMessage(err)])
                }
                else{
                    do {
                        let jsonData = try JSONEncoder().encode(data)
                        result(["success": success, "data": String(data: jsonData, encoding: .utf8) ?? ""])
                    }
                    catch {
                        result(["success": success, "error": "Error decoding data into correct format"])
                    }
                }
			}
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
		toWebhook: Bool,
		result: @escaping FlutterResult
	) {
		let c = connectionParse(connection: connection)
		if c != nil && terra != nil {
			terra!.getNutrition(
				type: c!,
				startDate: startDate,
				endDate: endDate,
				toWebhook: toWebhook
			){
				(success, data, err) in 
                if let err = err {
                    result(["success": false, "data": nil, "error": self.errorMessage(err)])
                }
                else{
                    do {
                        let jsonData = try JSONEncoder().encode(data)
                        result(["success": success, "data": String(data: jsonData, encoding: .utf8) ?? ""])
                    }
                    catch {
                        result(["success": success, "error": "Error decoding data into correct format"])
                    }
                }
			}
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
		toWebhook: Bool,
		result: @escaping FlutterResult
	) {
		let c = connectionParse(connection: connection)
		if c != nil && terra != nil {
			terra!.getSleep(
				type: c!,
				startDate: startDate,
				endDate: endDate,
				toWebhook: toWebhook
			){
				(success, data, err) in 
                if let err = err {
                    result(["success": false, "data": nil, "error": self.errorMessage(err)])
                }
                else{
                    do {
                        let jsonData = try JSONEncoder().encode(data)
                        result(["success": success, "data": String(data: jsonData, encoding: .utf8) ?? ""])
                    }
                    catch {
                        result(["success": success, "error": "Error decoding data into correct format"])
                    }
                }
			}
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
		terra?.activateSensor{(details) in
            do {
                let jsonData = try JSONEncoder().encode(details)
                result(String(data: jsonData, encoding: .utf8) ?? "")
            }
            catch {
                result(nil)
            }
        }
	}

	func getPlannedWorkouts(connection: String, result: @escaping FlutterResult){
		let c = connectionParse(connection: connection)
		guard let c = c else {
			result(FlutterError(
				code: "Could not parse connection",
				message: "Could not call getter for type: plannedWorkout. make sure you are passing a valid Connection type",
				details: nil
			))
			return
		}

		guard let terra = terra else {
			result(FlutterError(
				code: "Terra not initialised",
				message: "Terra not initialised. Please run initTerra first",
				details: nil
			))
			return
		}

		if #available(iOS 17.0, *) {
			terra.getPlannedWorkouts(
				type: c
			){
				(data, err) in 
                if let err = err {
                    result(["success": false, "data": nil, "error": self.errorMessage(err)])
                }
                else{
                    do {
                        let jsonData = try JSONEncoder().encode(data)
                        result(["success": true, "data": String(data: jsonData, encoding: .utf8) ?? ""])
                    }
                    catch {
                        result(["success": false, "error": "Error decoding data into correct format"])
                    }
                }
			}
		} else {
			result(FlutterError(
				code: "iOS Version Error",
				message: "Please make sure the iOS Version is 17.0 and above",
				details: nil
			))
		}
	}

	func deletePlannedWorkout(connection: String, workoutId: String, result: @escaping FlutterResult){
		let c = connectionParse(connection: connection)

		guard let c = c else {
			result(FlutterError(
				code: "Could not parse connection",
				message: "Could not call getter for type: plannedWorkout. make sure you are passing a valid Connection type",
				details: nil
			))
			return
		}

		guard let terra = terra else {
			result(FlutterError(
				code: "Terra not initialised",
				message: "Terra not initialised. Please run initTerra first",
				details: nil
			))
			return
		}

		guard let uuid = UUID(uuidString: workoutId) else {
			result(FlutterError(
				code: "Invalid UUID",
				message: "Please make sure the workoutId is a valid UUID",
				details: nil
			))
			return
		}

		if #available(iOS 17.0, *) {
			terra.deletePlannedWorkout(
				type: c,
				id: uuid
			){
				(success, err) in 
				if let err = err {
					result(["success": false, "error": self.errorMessage(err)])
				}
				else{
					result(["success": success])
				}
			}
		} else {
			result(FlutterError(
				code: "iOS Version Error",
				message: "Please make sure the iOS Version is 17.0 and above",
				details: nil
			))
		}
	}

	func completePlannedWorkout(connection: String, workoutId: String, at: Date, result: @escaping FlutterResult){
		let c = connectionParse(connection: connection)

		guard let c = c else {
			result(FlutterError(
				code: "Could not parse connection",
				message: "Could not call getter for type: plannedWorkout. make sure you are passing a valid Connection type",
				details: nil
			))
			return
		}

		guard let terra = terra else {
			result(FlutterError(
				code: "Terra not initialised",
				message: "Terra not initialised. Please run initTerra first",
				details: nil
			))
			return
		}


		guard let uuid = UUID(uuidString: workoutId) else {
			result(FlutterError(
				code: "Invalid UUID",
				message: "Please make sure the workoutId is a valid UUID",
				details: nil
			))
			return
		}

		if #available(iOS 17.0, *) {
			terra.markPlannedWorkoutComplete(
				type: c,
				id: uuid,
				at: at
			){
				(success, err) in 
				if let err = err {
					result(["success": false, "error": self.errorMessage(err)])
				}
				else{
					result(["success": success])
				}
			}
		} else {
			result(FlutterError(
				code: "iOS Version Error",
				message: "Please make sure the iOS Version is 17.0 and above",
				details: nil
			))
		}
	}

	func postPlannedWorkout(connection: String, workout: String, result: @escaping FlutterResult){
		let c = connectionParse(connection: connection)

		guard let c = c else {
			result(FlutterError(
				code: "Could not parse connection",
				message: "Could not call getter for type: plannedWorkout. make sure you are passing a valid Connection type",
				details: nil
			))
			return
		}

		guard let terra = terra else {
			result(FlutterError(
				code: "Terra not initialised",
				message: "Terra not initialised. Please run initTerra first",
				details: nil
			))
			return
		}

		if #available(iOS 17.0, *) {
			do {
				let data = try JSONDecoder().decode(TerraPlannedWorkout.self, from: workout.data(using: .utf8)!)
				terra.postPlannedWorkout(
					type: c,
					payload: data
				){
					(success, err) in 
					if let err = err {
						result(["success": false, "error": self.errorMessage(err)])
					}
					else{
						result(["success": success])
					}
				}
			}
			catch {
				result(FlutterError(
					code: "PlannedWorkoutPayload Error",
					message: "Could not parse the payload. Please make sure the payload is in the correct format \(error)",
					details: "\(workout)"
				))
			}
		} else {
			result(FlutterError(
				code: "iOS Version Error",
				message: "Please make sure the iOS Version is 17.0 and above",
				details: nil
			))
		}
	}



	// exposed handler
	// parse arguments and call appropriate function
	public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
		let dateFormatter = ISO8601DateFormatter()
		dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
		let args = call.arguments as? [String: Any] ?? [:]
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
						toWebhook: args["toWebhook"] as! Bool,
						result: result
					)
					break;
				case "getDaily":
					getDaily(
						connection: args["connection"] as! String,
						startDate: dateFormatter.date(from: args["startDate"] as! String)!,
						endDate: dateFormatter.date(from: args["endDate"] as! String)!,
						toWebhook: args["toWebhook"] as! Bool,
						result: result
					)
					break;
				case "getNutrition":
					getNutrition(
						connection: args["connection"] as! String,
						startDate: dateFormatter.date(from: args["startDate"] as! String)!,
						endDate: dateFormatter.date(from: args["endDate"] as! String)!,
						toWebhook: args["toWebhook"] as! Bool,
						result: result
					)
					break;
				case "getAthlete":
					getAthlete(
						connection: args["connection"] as! String,
						toWebhook: args["toWebhook"] as! Bool,
						result: result
					)
					break;
				case "getSleep":
					getSleep(
						connection: args["connection"] as! String,
						startDate: dateFormatter.date(from: args["startDate"] as! String)!,
						endDate: dateFormatter.date(from: args["endDate"] as! String)!,
						toWebhook: args["toWebhook"] as! Bool,
						result: result
					)
					break;
				case "getActivity":
					getActivity(
						connection: args["connection"] as! String,
						startDate: dateFormatter.date(from: args["startDate"] as! String)!,
						endDate: dateFormatter.date(from: args["endDate"] as! String)!,
						toWebhook: args["toWebhook"] as! Bool,
						result: result
					)
					break;
				case "getMenstruation":
					getMenstruation(
						connection: args["connection"] as! String,
						startDate: dateFormatter.date(from: args["startDate"] as! String)!,
						endDate: dateFormatter.date(from: args["endDate"] as! String)!,
						toWebhook: args["toWebhook"] as! Bool,
						result: result
					)
					break;
				case "readGlucoseData":
					readGlucoseData(result: result)
					break;
				case "activateGlucoseSensor":
					activateGlucoseSensor(result: result)
					break;
				case "getPlannedWorkouts":
					getPlannedWorkouts(connection: args["connection"] as! String, result: result)
					break;
				case "deletePlannedWorkout":
					deletePlannedWorkout(connection: args["connection"] as! String, workoutId: args["workoutId"] as! String, result: result)
					break;
				case "completePlannedWorkout":
					completePlannedWorkout(connection: args["connection"] as! String, workoutId: args["workoutId"] as! String, at: dateFormatter.date(from: args["at"] as! String)!,  result: result)
					break;
				case "postPlannedWorkout":
					postPlannedWorkout(connection: args["connection"] as! String, workout: args["payload"] as! String, result: result)
					break;
				default:
					result(FlutterMethodNotImplemented)
		}
	}
}
