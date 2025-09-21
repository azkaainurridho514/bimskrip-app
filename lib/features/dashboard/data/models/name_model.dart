import 'package:bimskrip/features/dashboard/bussines/entities/user.dart';

import '../../bussines/entities/name.dart';

class NameModel {
  final int statusCode;
  final String message;
  final List<Names> data;
  NameModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory NameModel.fromJson(Map<String, dynamic> json) {
    return NameModel(
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? "",
      data:
          (json['data'] is List)
              ? List<Names>.from(json['data'].map((v) => Names.fromJson(v)))
              : [],
    );
  }

  int get sc => statusCode;
  String get ms => message;
  List<Names> get dt => data;
  Map<String, dynamic> toJson() {
    return {"status_code": statusCode, "message": message, "data": data};
  }
}
