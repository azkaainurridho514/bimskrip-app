import 'role.dart';

class Names {
  final int id;
  final String name;
  Names({required this.id, required this.name});
  factory Names.fromJson(dynamic json) {
    return Names(id: json['id'], name: json['name']);
  }

  int get Id => id;
  String get Name => name;
  Map<String, dynamic> toJson() {
    return {"id": id, "name": name};
  }
}
