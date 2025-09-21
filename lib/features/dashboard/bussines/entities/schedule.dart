import 'package:bimskrip/features/dashboard/bussines/entities/user.dart';

class Schedule {
  final int id;
  final String date;
  final int mhsId;
  final int dosenPAId;
  final String tempat;
  final User? student;
  final User? dosenPA;

  Schedule({
    required this.id,
    required this.mhsId,
    required this.dosenPAId,
    required this.tempat,
    required this.date,
    this.student,
    this.dosenPA,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] ?? 0,
      mhsId: json['mhs_id'] ?? 0,
      date: json['date'] ?? "",
      tempat: json['tempat'] ?? "",
      dosenPAId: json['dosen_pa_id'] ?? 0,
      student: json['student'] == null ? null : User.fromJson(json['student']),
      dosenPA:
          json['dosen_pa'] == null ? null : User.fromJson(json['dosen_pa']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "mhs_id": mhsId,
      "date": date,
      "tempat": tempat,
      "dosen_pa": dosenPA?.toJson(),
      "dosen_pa_id": dosenPAId,
      "student": student!.toJson(),
    };
  }
}
