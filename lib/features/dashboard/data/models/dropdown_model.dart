import '../../bussines/entities/dropdown.dart';

class DropdownModel {
  final int statusCode;
  final String message;
  final List<Dropdown> data;
  DropdownModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory DropdownModel.fromJson(Map<String, dynamic> json) {
    return DropdownModel(
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? "",
      data:
          (json['data'] is List)
              ? List<Dropdown>.from(
                json['data'].map((v) => Dropdown.fromJson(v)),
              )
              : [],
    );
  }

  int get sc => statusCode;
  String get ms => message;
  List<Dropdown> get dt => data;
  Map<String, dynamic> toJson() {
    return {"status_code": statusCode, "message": message, "data": data};
  }
}
