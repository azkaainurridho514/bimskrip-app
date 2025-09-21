import 'role.dart';

class User {
  final int id;
  final int roleId;
  final int dosenPAID;
  final String name;
  final String phone;
  final String email;
  final String password;
  final String photo;
  final Role? role;
  final User? dosenPA;
  User({
    required this.id,
    required this.roleId,
    required this.dosenPAID,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.role,
    required this.dosenPA,
    required this.photo,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      roleId: json['role_id'],
      dosenPAID: json['dosen_pa_id'] ?? 0,
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
      photo: json['photo'] ?? "",
      role: json["role"] == null ? null : Role.fromJson(json["role"]),
      dosenPA:
          json["dosen_pa"] == null ? null : User.fromJson(json['dosen_pa']),
    );
  }

  int get Id => id;
  int get RoleId => roleId;
  int get DosenPAID => dosenPAID;
  String get Name => name;
  String get Phone => phone;
  String get Email => email;
  String get Password => password;
  String get Photo => photo;
  Role? get Roles => role;
  User? get DosenPA => dosenPA;
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "role_id": roleId,
      "dosen_pa_id": dosenPAID,
      "name": name,
      "phone": phone,
      "email": email,
      "password": password,
      "photo": photo,
      "role": role,
      "dosen_pa": dosenPA,
    };
  }
}
