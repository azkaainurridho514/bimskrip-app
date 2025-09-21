import 'package:bimskrip/features/dashboard/bussines/entities/progres_name.dart';
import 'package:bimskrip/features/dashboard/bussines/entities/status.dart';
import 'package:bimskrip/features/dashboard/bussines/entities/user.dart';

class Progres {
  final int id;
  final int mhsId;
  final int nameId;
  final int statusId;
  final int dosenPAId;
  final String desc;
  final String url;
  final String comment;
  final String createdAt;
  final User? student;
  final ProgresName? progres;
  final Status? status;

  Progres({
    required this.id,
    required this.mhsId,
    required this.nameId,
    required this.statusId,
    required this.dosenPAId,
    required this.desc,
    required this.url,
    required this.comment,
    required this.student,

    required this.progres,
    required this.status,
    required this.createdAt,
  });

  factory Progres.fromJson(Map<String, dynamic> json) {
    return Progres(
      id: json['id'] ?? 0,
      mhsId: json['mhs_id'] ?? 0,
      nameId: json['name_id'] ?? 0,
      statusId: json['status_id'] ?? 0,
      dosenPAId: json['dosen_pa_id'] ?? 0,
      desc: json['desc'] ?? "",
      student: json['student'] == null ? null : User.fromJson(json['student']),
      progres:
          json['progress_name'] == null
              ? null
              : ProgresName.fromJson(json['progress_name']),
      status: json['status'] == null ? null : Status.fromJson(json['status']),

      createdAt: json['created_at'] ?? "",
      url: json['url'] ?? "",
      comment: json['comment'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "mhs_id": mhsId,
      "name_id": nameId,
      "status_id": statusId,
      "dosen_pa_id": dosenPAId,
      "file_nama": desc,
      "student": student!.toJson(),
      "progress_name": progres!.toJson(),
      "status": status!.toJson(),
      "created_at": createdAt,
      "url": url,
      "comment": comment,
    };
  }
}
