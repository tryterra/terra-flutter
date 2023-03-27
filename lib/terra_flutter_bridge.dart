import 'dart:async';
import 'dart:convert';

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
  menstruation,
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
      case CustomPermission.menstruation:
        return 'MENSTRUATION';
      default:
        return 'UNDEFINED';
    }
  }
}

class SuccessMessage{
  final bool? success;
  final String? error;

  SuccessMessage(this.success, this.error);

  SuccessMessage.fromJson(Map<String, dynamic> json)
    : success = json["success"],
    error = json.containsKey('error') ? (json['error']) : null;
}

class UserId{
  final bool? success;
  final String? userId;

  UserId(this.success, this.userId);

  UserId.fromJson(Map<String, dynamic> json)
    : success = json["success"],
    userId = json.containsKey('userId') ? (json['userId']) : null;
}

class DataMessage{
  final bool? success;
  final Map<String, dynamic>? data;
  final String? error;

  DataMessage(this.success, this.data, this.error);

  DataMessage.fromJson(Map<String, dynamic> json)
    : success = json["success"],
    data = json.containsKey("data") && json["data"] != null ? (jsonDecode(json["data"])) : null,
    error = json.containsKey('error') ? (json['error']) : null;
}

// Functions bridging
class TerraFlutter {
  static const MethodChannel _channel = MethodChannel('terra_flutter_bridge');

  static Future<String?> testFunction(String text) async {
    final String? version =
        await _channel.invokeMethod('testFunction', {"text": text});
    return version;
  }

  static Future<SuccessMessage?> initTerra(
      String devID,
      String referenceID) async {
    return SuccessMessage.fromJson(Map<String, dynamic>.from(await _channel.invokeMethod('initTerra', {
      "devID": devID,
      "referenceID": referenceID,
    })));
  }

  static Future<SuccessMessage?> initConnection(
      Connection connection,
      String token,
      bool schedulerOn,
      List<CustomPermission> customPermissions) async {
    return SuccessMessage.fromJson(Map<String, dynamic>.from(await _channel.invokeMethod('initConnection', {
      "connection": connection.connectionString,
      "token": token,
      "schedulerOn": schedulerOn,
      "customPermissions":
          customPermissions.map((c) => c.customPermissionString).toList()
    })));
  }

  static Future<UserId?> getUserId(Connection connection) async {
    return UserId.fromJson(Map<String, dynamic>.from(await _channel
        .invokeMethod('getUserId', {"connection": connection.connectionString})));
  }

  static Future<bool> isHealthConnectAvailable() async{
    return await _channel.invokeMethod("isHealthConnectAvailable");
  }
  
  static Future<DataMessage?> getActivity(
      Connection connection, DateTime startDate, DateTime endDate, {bool toWebhook = true} ) async {
    return DataMessage.fromJson(Map<String, dynamic>.from(await _channel.invokeMethod('getActivity', {
      "connection": connection.connectionString,
      "startDate": convertToProperIsoFormat(startDate),
      "endDate": convertToProperIsoFormat(endDate),
      "toWebhook": toWebhook
    })));
  }

  static Future<DataMessage?> getAthlete(Connection connection, {bool toWebhook = true}) async {
    return DataMessage.fromJson(Map<String, dynamic>.from(await _channel.invokeMethod(
        'getAthlete', {"connection": connection.connectionString, "toWebhook": toWebhook})));
  }

  static Future<DataMessage?> getBody(
      Connection connection, DateTime startDate, DateTime endDate, {bool toWebhook = true}) async {
    return DataMessage.fromJson(Map<String, dynamic>.from(await _channel.invokeMethod('getBody', {
      "connection": connection.connectionString,
      "startDate": convertToProperIsoFormat(startDate),
      "endDate": convertToProperIsoFormat(endDate),
      "toWebhook": toWebhook
    })));
  }

  static Future<DataMessage?> getDaily(
      Connection connection, DateTime startDate, DateTime endDate, {bool toWebhook = true}) async {
    return DataMessage.fromJson(Map<String, dynamic>.from(await _channel.invokeMethod('getDaily', {
      "connection": connection.connectionString,
      "startDate": convertToProperIsoFormat(startDate),
      "endDate": convertToProperIsoFormat(endDate),
      "toWebhook": toWebhook
    })));
  }

    static Future<DataMessage?> getMenstruation(
      Connection connection, DateTime startDate, DateTime endDate, {bool toWebhook = true}) async {
    return DataMessage.fromJson(Map<String, dynamic>.from(await _channel.invokeMethod('getMenstruation', {
      "connection": connection.connectionString,
      "startDate": convertToProperIsoFormat(startDate),
      "endDate": convertToProperIsoFormat(endDate),
      "toWebhook": toWebhook
    })));
  }

  static Future<DataMessage?> getNutrition(
      Connection connection, DateTime startDate, DateTime endDate, {bool toWebhook = true}) async {
    return DataMessage.fromJson(Map<String, dynamic>.from(await _channel.invokeMethod('getNutrition', {
      "connection": connection.connectionString,
      "startDate": convertToProperIsoFormat(startDate),
      "endDate": convertToProperIsoFormat(endDate),
      "toWebhook": toWebhook
    })));
  }

  static Future<DataMessage?> getSleep(
      Connection connection, DateTime startDate, DateTime endDate, {bool toWebhook = true}) async {
    return DataMessage.fromJson(Map<String, dynamic>.from(await _channel.invokeMethod('getSleep', {
      "connection": connection.connectionString,
      "startDate": convertToProperIsoFormat(startDate),
      "endDate": convertToProperIsoFormat(endDate),
      "toWebhook": toWebhook
    })));
  }

  static Future<String?> activateGlucoseSensor() async {
    final String? success = await _channel.invokeMethod('activateGlucoseSensor');
    return success;
  }

  // only for apple
  static Future<String?> readGlucoseData() async {
    final String? success = await _channel.invokeMethod('readGlucoseData');
    return success;
  }
}
