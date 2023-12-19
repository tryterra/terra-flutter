// SDK connections
import 'dart:convert';

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

class ListDataMessage {
  final bool? success;
  final List<dynamic>? data;
  final String? error;

  ListDataMessage(this.success, this.data, this.error);

  ListDataMessage.fromJson(Map<String, dynamic> json)
    : success = json["success"],
    data = json.containsKey("data") && json["data"] != null ? (jsonDecode(json["data"])) : null,
    error = json.containsKey('error') ? (json['error']) : null;
}