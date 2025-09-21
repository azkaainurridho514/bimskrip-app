import 'package:bimskrip/features/dashboard/bussines/entities/progres.dart';

class ProgresModel {
  ProgresModel({
    required int statusCode,
    required String message,
    required List<Progres> data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  ProgresModel.fromJson(Map<String, dynamic> json) {
    _statusCode = json['status_code'] ?? 0;
    _message = json['message'] ?? "";
    _data =
        (json['data'] is List)
            ? List<Progres>.from(json['data'].map((v) => Progres.fromJson(v)))
            : [];
    // return ProgresModel(
    //   statusCode: json['status_code'] ?? 0,
    //   message: json['message'] ?? "",
    //   data:
    //       (json['data'] is List)
    //           ? List<Progres>.from(json['data'].map((v) => Progres.fromJson(v)))
    //           : [],
    // );
  }
  late int _statusCode;
  late String _message;
  late List<Progres> _data;

  int get statusCode => _statusCode;
  String get message => _message;
  List<Progres> get data => _data;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ProgresCreateModel {
  final int statusCode;
  final String message;
  // final Progres data;
  ProgresCreateModel({
    required this.statusCode,
    required this.message,
    // required this.data,
  });

  factory ProgresCreateModel.fromJson(Map<String, dynamic> json) {
    return ProgresCreateModel(
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? "",
      // data: Progres.fromJson(json['data'] ?? {}),
    );
  }

  int get sc => statusCode;
  String get ms => message;
  // Progres get dt => data;
  Map<String, dynamic> toJson() {
    return {
      "status_code": statusCode,
      "message": message,
      // "data": data.toJson(),
    };
  }
}
