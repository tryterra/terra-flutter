import 'dart:async';

import 'package:flutter/services.dart';

class TerraFlutter {
  static const MethodChannel _channel = MethodChannel('terra_flutter');

  static Future<String?> testFunction(String text) async {
    final String? version =
        await _channel.invokeMethod('testFunction', {"text": text});
    return version;
  }

  static Future<bool?> initTerra(
      String devID,
      String apiKey,
      String referenceID,
      int intervalMinutes,
      List<String> connections,
      List<String> permissions) async {
    final bool? success = await _channel.invokeMethod('initTerra', {
      "devID": devID,
      "apiKey": apiKey,
      "referenceID": referenceID,
      "intervalMinutes": intervalMinutes,
      "connections": connections,
      "permissions": permissions
    });
    return success;
  }

  static Future<bool?> checkAuth(String connection) async {
    final bool? success =
        await _channel.invokeMethod('checkAuth', {"connection": connection});
    return success;
  }

  static Future<bool?> getActivity(
      String connection, DateTime startDate, DateTime endDate) async {
    final bool? success = await _channel.invokeMethod('getActivity', {
      "connection": connection,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String()
    });
    return success;
  }

  static Future<bool?> getAthlete(String connection) async {
    final bool? success =
        await _channel.invokeMethod('getAthlete', {"connection": connection});
    return success;
  }

  static Future<bool?> getBody(
      String connection, DateTime startDate, DateTime endDate) async {
    final bool? success = await _channel.invokeMethod('getBody', {
      "connection": connection,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String()
    });
    return success;
  }

  static Future<bool?> getDaily(
      String connection, DateTime startDate, DateTime endDate) async {
    final bool? success = await _channel.invokeMethod('getDaily', {
      "connection": connection,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String()
    });
    return success;
  }

  static Future<bool?> getNutrition(
      String connection, DateTime startDate, DateTime endDate) async {
    final bool? success = await _channel.invokeMethod('getNutrition', {
      "connection": connection,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String()
    });
    return success;
  }

  static Future<bool?> getSleep(
      String connection, DateTime startDate, DateTime endDate) async {
    final bool? success = await _channel.invokeMethod('getSleep', {
      "connection": connection,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String()
    });
    return success;
  }

  static Future<bool?> deauth(String connection) async {
    final bool? success =
        await _channel.invokeMethod('deauth', {"connection": connection});
    return success;
  }

  static Future<bool?> readGlucoseData() async {
    final bool? success = await _channel.invokeMethod('readGlucoseData');
    return success;
  }
}
