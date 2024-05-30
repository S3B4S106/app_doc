class Plant {
  String id;
  String name;
  int limit;

  Plant({required this.id, required this.name, required this.limit});

  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(id: map['id'], name: map['name'], limit: map['limit']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'userName': name, 'limit': limit};
  }
}
