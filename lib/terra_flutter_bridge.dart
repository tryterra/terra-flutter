import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:terra_flutter_bridge/models/enums.dart';
import 'package:terra_flutter_bridge/models/responses.dart';
import 'package:terra_flutter_bridge/models/planned_workout.dart';

String convertToProperIsoFormat(DateTime date){
      return date.toUtc().toIso8601String();
}

// Rounds up so the floor can only move later, never admitting older samples.
// Milliseconds because the iOS ISO8601 parser rejects six fractional digits.
int millisecondCeiling(DateTime date) {
  return (date.toUtc().microsecondsSinceEpoch /
          Duration.microsecondsPerMillisecond)
      .ceil();
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

  /// [dataStartDate] is Apple Health only. No other connection has an equivalent
  /// floor, and the Android plugin drops the argument, so passing it for anything
  /// else throws rather than being silently ignored.
  static Future<SuccessMessage?> initConnection(
      Connection connection,
      String token,
      bool schedulerOn,
      List<CustomPermission> customPermissions,
      {DateTime? dataStartDate}) async {
    if (dataStartDate != null && connection != Connection.appleHealth) {
      throw ArgumentError.value(dataStartDate, 'dataStartDate',
          'only Apple Health supports a data start date');
    }
    return SuccessMessage.fromJson(Map<String, dynamic>.from(await _channel.invokeMethod('initConnection', {
      "connection": connection.connectionString,
      "token": token,
      "schedulerOn": schedulerOn,
      "customPermissions":
          customPermissions.map((c) => c.customPermissionString).toList(),
      "dataStartDate": dataStartDate != null
          ? convertToProperIsoFormat(DateTime.fromMillisecondsSinceEpoch(
              millisecondCeiling(dataStartDate),
              isUtc: true))
          : null
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

  static Future<ListDataMessage?> getPlannedWorkouts(
      Connection connection) async {
    return ListDataMessage.fromJson(Map<String, dynamic>.from(await _channel.invokeMethod('getPlannedWorkouts', {
      "connection": connection.connectionString
    })));
  }

  static Future<SuccessMessage?> deletePlannedWorkout(
      Connection connection, String id) async {
    return SuccessMessage.fromJson(Map<String, dynamic>.from(await _channel.invokeMethod('deletePlannedWorkout', {
      "connection": connection.connectionString,
      "workoutId": id
    })));
  }

  static Future<SuccessMessage?> completePlannedWorkout(
      Connection connection, String id, DateTime? at ) async {
    return SuccessMessage.fromJson(Map<String, dynamic>.from(await _channel.invokeMethod('completePlannedWorkout', {
      "connection": connection.connectionString,
      "workoutId": id,
      "at": convertToProperIsoFormat(at ?? DateTime.now())
    })));
  }

  static Future<SuccessMessage?> postPlannedWorkout(
      Connection connection, TerraPlannedWorkout payload) async {
    return SuccessMessage.fromJson(Map<String, dynamic>.from(await _channel.invokeMethod('postPlannedWorkout', {
      "connection": connection.connectionString,
      "payload": jsonEncode(payload.toJson())
    })));
  }

  static Future<Set<String>> getGivenPermissions() async {
    return Set<String>.from(await _channel.invokeMethod('getGivenPermissions'));
  }
}