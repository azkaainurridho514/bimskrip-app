import 'package:bimskrip/features/dashboard/bussines/entities/user.dart';

class MahasiswaByDosenModel {
  final int statusCode;
  final String message;
  final List<User> data;
  MahasiswaByDosenModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory MahasiswaByDosenModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaByDosenModel(
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? "",
      data:
          (json['data'] is List)
              ? List<User>.from(json['data'].map((v) => User.fromJson(v)))
              : [],
    );
  }

  int get sc => statusCode;
  String get ms => message;
  List<User> get dt => data;
  Map<String, dynamic> toJson() {
    return {"status_code": statusCode, "message": message, "data": data};
  }
}
