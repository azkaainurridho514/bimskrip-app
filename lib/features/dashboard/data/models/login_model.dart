import 'package:bimskrip/features/dashboard/bussines/entities/user.dart';

class LoginAndRegisterModel {
  final int statusCode;
  final String message;
  final User? data;
  LoginAndRegisterModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LoginAndRegisterModel.fromJson(Map<String, dynamic> json) {
    return LoginAndRegisterModel(
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? "",
      data:
          json['data'].toString() == "[]" ? null : User.fromJson(json['data']),
    );
  }

  int get sc => statusCode;
  String get ms => message;
  User? get dt => data;
  Map<String, dynamic> toJson() {
    return {
      "status_code": statusCode,
      "message": message,
      "data": data == null ? [] : data!.toJson(),
    };
  }
}
