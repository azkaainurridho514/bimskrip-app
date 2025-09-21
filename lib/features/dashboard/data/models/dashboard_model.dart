import '../../bussines/entities/dashboard.dart';

class DashboardModel {
  final int statusCode;
  final String message;
  final Dashboard? data;
  DashboardModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? "",
      data:
          json['data'].toString() == "[]"
              ? null
              : Dashboard.fromJson(json['data']),
    );
  }

  int get sc => statusCode;
  String get ms => message;
  Dashboard? get dt => data;
  Map<String, dynamic> toJson() {
    return {
      "status_code": statusCode,
      "message": message,
      "data": data!.toJson(),
    };
  }
}
