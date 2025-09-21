class ProgresName {
  final int id;
  final String name;
  ProgresName({required this.id, required this.name});

  factory ProgresName.fromJson(Map<String, dynamic> json) {
    return ProgresName(id: json['id'] ?? "", name: json['name'] ?? "");
  }
  String get Name => name;
  int get ID => id;
  Map<String, dynamic> toJson() {
    return {"id": id, "name": name};
  }
}
