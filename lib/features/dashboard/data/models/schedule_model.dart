import '../../bussines/entities/schedule.dart';

class ScheduleModel {
  final int statusCode;
  final String message;
  final List<Schedule> data;
  ScheduleModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? "",
      data:
          (json['data'] is List)
              ? List<Schedule>.from(
                json['data'].map((v) => Schedule.fromJson(v)),
              )
              : [],
    );
  }

  int get sc => statusCode;
  String get ms => message;
  List<Schedule> get dt => data;
  Map<String, dynamic> toJson() {
    return {
      "status_code": statusCode,
      "message": message,
      "data": data.map((v) => v.toJson()).toList(),
    };
  }
}
