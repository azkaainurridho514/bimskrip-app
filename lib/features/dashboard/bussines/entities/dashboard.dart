import 'role.dart';

class Dashboard {
  final UserCount? users;
  final ProgresCount? progress;
  Dashboard({required this.users, required this.progress});
  factory Dashboard.fromJson(dynamic json) {
    return Dashboard(
      progress:
          json['data'].toString() == "[]"
              ? null
              : ProgresCount.fromJson(json['progress']),
      users:
          json['data'].toString() == "[]"
              ? null
              : UserCount.fromJson(json['users']),
    );
  }

  ProgresCount? get progres => progress;
  UserCount? get user => users;
  Map<String, dynamic> toJson() {
    return {"users": users!.toJson(), "progress": progress!.toJson()};
  }
}

class UserCount {
  final int totalDosen;
  final int totalMahasiswa;
  UserCount({required this.totalDosen, required this.totalMahasiswa});
  factory UserCount.fromJson(dynamic json) {
    return UserCount(
      totalMahasiswa: json['total_mahasiswa'] ?? 0,
      totalDosen: json['total_dosen'] ?? 0,
    );
  }

  int get dosen => totalDosen;
  int get mahasiswa => totalMahasiswa;
  Map<String, dynamic> toJson() {
    return {"total_mahasiswa": totalMahasiswa, "total_dosen": totalDosen};
  }
}

class ProgresCount {
  final int total;
  final int terima;
  final int tolak;
  final int pending;
  ProgresCount({
    required this.total,
    required this.terima,
    required this.tolak,
    required this.pending,
  });
  factory ProgresCount.fromJson(dynamic json) {
    return ProgresCount(
      pending: json["pending"] ?? 0,
      terima: json["terima"] ?? 0,
      tolak: json["tolak"] ?? 0,
      total: json["total"] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "terima": terima,
      "pending": pending,
      "tolak": tolak,
      "total": total,
    };
  }
}
