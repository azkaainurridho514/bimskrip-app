class Role {
  final int id;
  final String name;
  Role({required this.id, required this.name});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(id: json['id'] ?? "", name: json['name'] ?? "");
  }

  int get sc => id;
  String get ms => name;
  Map<String, dynamic> toJson() {
    return {"id": id, "name": name};
  }
}
