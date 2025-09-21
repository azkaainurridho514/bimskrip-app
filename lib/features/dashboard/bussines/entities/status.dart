class Status {
  final int id;
  final String name;
  Status({required this.id, required this.name});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(id: json['id'] ?? "", name: json['name'] ?? "");
  }
  String get Name => name;
  int get ID => id;
  Map<String, dynamic> toJson() {
    return {"id": id, "name": name};
  }
}
