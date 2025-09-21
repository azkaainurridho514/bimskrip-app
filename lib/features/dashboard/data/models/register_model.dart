import 'package:bimskrip/features/dashboard/bussines/entities/user.dart';

class RegisterModel {
  final String statusCode;
  final String message;
  final User? data;
  RegisterModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      statusCode: json['status_code'] ?? "",
      message: json['message'] ?? "",
      data: User?.fromJson(json['data']),
    );
  }

  String get sc => statusCode;
  String get ms => message;
  User? get dt => data;
  Map<String, dynamic> toJson() {
    return {
      "status_code": statusCode,
      "message": message,
      "data": data?.toJson(),
    };
  }
}
