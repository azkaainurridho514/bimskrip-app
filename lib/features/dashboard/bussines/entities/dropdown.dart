import 'role.dart';

class Dropdown {
  final int id;
  final String name;
  final String phone;
  final String email;
  Dropdown({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });
  factory Dropdown.fromJson(dynamic json) {
    return Dropdown(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
    );
  }

  int get Id => id;
  String get Name => name;
  String get Phone => phone;
  String get Email => email;
  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "phone": phone, "email": email};
  }
}
