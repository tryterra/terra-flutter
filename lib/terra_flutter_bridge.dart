import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';


String convertToProperIsoFormat(DateTime date){
      return date.toUtc().toIso8601String();
}

// SDK connections
enum Connection {
  appleHealth,
  googleFit,
  samsung,
  freestyleLibre,
}

extension ConnectionExtension on Connection {
  String get connectionString {
    switch (this) {
      case Connection.appleHealth:
        return 'APPLE_HEALTH';
      case Connection.googleFit:
        return 'GOOGLE';
      case Connection.samsung:
        return 'SAMSUNG';
      case Connection.freestyleLibre:
        return 'FREESTYLE_LIBRE';
      default:
        return 'UNDEFINED';
    }
  }
}

// Custom permissions (per datatype)
enum CustomPermission {
  workoutTypes,
  activitySummary,
  location,
  calories,
  steps,
  heartRate,
  heartRateVariability,
  vo2max,
  height,
  activeDurations,
  weight,
  flightsClimbed,
  bmi,
  bodyFat,
  exerciseDistance,
  gender,
  dateOfBirth,
  basalEnergyBurned,
  swimmingSummary,
  restingHeartRate,
  bloodPressure,
  bloodGlucose,
  bodyTemperature,
  leanBodyMass,
  oxygenSaturation,
  sleepAnalysis,
  respiratoryRate,
  nutritionSodium,
  nutritionProtein,
  nutritionCarbohydrates,
  nutritionFibre,
  nutritionFatTotal,
  nutritionSugar,
  nutritionVitaminC,
  nutritionVitaminA,
  nutritionCalories,
  nutritionWater,
  nutritionCholesterol,
}

extension CustomPermissionExtension on CustomPermission {
  String get customPermissionString {
    switch (this) {
      case CustomPermission.workoutTypes:
        return 'WORKOUT_TYPES';
      case CustomPermission.activitySummary:
        return 'ACTIVITY_SUMMARY';
      case CustomPermission.location:
        return 'LOCATION';
      case CustomPermission.calories:
        return 'CALORIES';
      case CustomPermission.steps:
        return 'STEPS';
      case CustomPermission.heartRate:
        return 'HEART_RATE';
      case CustomPermission.heartRateVariability:
        return 'HEART_RATE_VARIABILITY';
      case CustomPermission.vo2max:
        return 'VO2MAX';
      case CustomPermission.height:
        return 'HEIGHT';
      case CustomPermission.activeDurations:
        return 'ACTIVE_DURATIONS';
      case CustomPermission.weight:
        return 'WEIGHT';
      case CustomPermission.flightsClimbed:
        return 'FLIGHTS_CLIMBED';
      case CustomPermission.bmi:
        return 'BMI';
      case CustomPermission.bodyFat:
        return 'BODY_FAT';
      case CustomPermission.exerciseDistance:
        return 'EXERCISE_DISTANCE';
      case CustomPermission.gender:
        return 'GENDER';
      case CustomPermission.dateOfBirth:
        return 'DATE_OF_BIRTH';
      case CustomPermission.basalEnergyBurned:
        return 'BASAL_ENERGY_BURNED';
      case CustomPermission.swimmingSummary:
        return 'SWIMMING_SUMMARY';
      case CustomPermission.restingHeartRate:
        return 'RESTING_HEART_RATE';
      case CustomPermission.bloodPressure:
        return 'BLOOD_PRESSURE';
      case CustomPermission.bloodGlucose:
        return 'BLOOD_GLUCOSE';
      case CustomPermission.bodyTemperature:
        return 'BODY_TEMPERATURE';
      case CustomPermission.leanBodyMass:
        return 'LEAN_BODY_MASS';
      case CustomPermission.oxygenSaturation:
        return 'OXYGEN_SATURATION';
      case CustomPermission.sleepAnalysis:
        return 'SLEEP_ANALYSIS';
      case CustomPermission.respiratoryRate:
        return 'RESPIRATORY_RATE';
      case CustomPermission.nutritionSodium:
        return 'NUTRITION_SODIUM';
      case CustomPermission.nutritionProtein:
        return 'NUTRITION_PROTEIN';
      case CustomPermission.nutritionCarbohydrates:
        return 'NUTRITION_CARBOHYDRATES';
      case CustomPermission.nutritionFibre:
        return 'NUTRITION_FIBRE';
      case CustomPermission.nutritionFatTotal:
        return 'NUTRITION_FAT_TOTAL';
      case CustomPermission.nutritionSugar:
        return 'NUTRITION_SUGAR';
      case CustomPermission.nutritionVitaminC:
        return 'NUTRITION_VITAMIN_C';
      case CustomPermission.nutritionVitaminA:
        return 'NUTRITION_VITAMIN_A';
      case CustomPermission.nutritionCalories:
        return 'NUTRITION_CALORIES';
      case CustomPermission.nutritionWater:
        return 'NUTRITION_WATER';
      case CustomPermission.nutritionCholesterol:
        return 'NUTRITION_CHOLESTEROL';
      default:
        return 'UNDEFINED';
    }
  }
}

// General permissions (per Terra scope)
enum Permission { athlete, activity, body, daily, nutrition, sleep }

extension PermissionExtension on Permission {
  String get permissionString {
    switch (this) {
      case Permission.activity:
        return 'ACTIVITY';
      case Permission.athlete:
        return 'ATHLETE';
      case Permission.body:
        return 'BODY';
      case Permission.daily:
        return 'DAILY';
      case Permission.nutrition:
        return 'NUTRITION';
      case Permission.sleep:
        return 'SLEEP';
      default:
        return 'UNDEFINED';
    }
  }
}

// Functions bridging
class TerraFlutter {
  static const MethodChannel _channel = MethodChannel('terra_flutter_bridge');

  static Future<String?> testFunction(String text) async {
    final String? version =
        await _channel.invokeMethod('testFunction', {"text": text});
    return version;
  }

  static Future<bool?> initTerra(
      String devID,
      String referenceID) async {
    final bool? success = await _channel.invokeMethod('initTerra', {
      "devID": devID,
      "referenceID": referenceID,
    });
    return success;
  }

  static Future<bool?> initConnection(
      Connection connection,
      String token,
      bool schedulerOn,
      List<CustomPermission> customPermissions) async {
    final bool? success = await _channel.invokeMethod('initConnection', {
      "connection": connection.connectionString,
      "token": token,
      "schedulerOn": schedulerOn,
      "customPermissions":
          customPermissions.map((c) => c.customPermissionString).toList()
    });
    return success;
  }

  static Future<String?> getUserId(Connection connection) async {
    final String? userId = await _channel
        .invokeMethod('getUserId', {"connection": connection.connectionString});
    return userId;
  }

  static Future<bool?> getActivity(
      Connection connection, DateTime startDate, DateTime endDate) async {
    final bool? success = await _channel.invokeMethod('getActivity', {
      "connection": connection.connectionString,
      "startDate": convertToProperIsoFormat(startDate),
      "endDate": convertToProperIsoFormat(endDate)
    });
    return success;
  }

  static Future<bool?> getAthlete(Connection connection) async {
    final bool? success = await _channel.invokeMethod(
        'getAthlete', {"connection": connection.connectionString});
    return success;
  }

  static Future<bool?> getBody(
      Connection connection, DateTime startDate, DateTime endDate) async {
    final bool? success = await _channel.invokeMethod('getBody', {
      "connection": connection.connectionString,
      "startDate": convertToProperIsoFormat(startDate),
      "endDate": convertToProperIsoFormat(endDate)
    });
    return success;
  }

  static Future<bool?> getDaily(
      Connection connection, DateTime startDate, DateTime endDate) async {
    final bool? success = await _channel.invokeMethod('getDaily', {
      "connection": connection.connectionString,
      "startDate": convertToProperIsoFormat(startDate),
      "endDate": convertToProperIsoFormat(endDate)
    });
    return success;
  }

  static Future<bool?> getNutrition(
      Connection connection, DateTime startDate, DateTime endDate) async {
    final bool? success = await _channel.invokeMethod('getNutrition', {
      "connection": connection.connectionString,
      "startDate": convertToProperIsoFormat(startDate),
      "endDate": convertToProperIsoFormat(endDate)
    });
    return success;
  }

  static Future<bool?> getSleep(
      Connection connection, DateTime startDate, DateTime endDate) async {
    final bool? success = await _channel.invokeMethod('getSleep', {
      "connection": connection.connectionString,
      "startDate": convertToProperIsoFormat(startDate),
      "endDate": convertToProperIsoFormat(endDate)
    });
    return success;
  }

  static Future<bool?> activateGlucoseSensor() async {
    final bool? success = await _channel.invokeMethod('activateGlucoseSensor');
    return success;
  }

  // only for apple
  static Future<String?> readGlucoseData() async {
    final String? success = await _channel.invokeMethod('readGlucoseData');
    return success;
  }
}
