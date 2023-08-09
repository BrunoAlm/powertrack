import 'dart:convert';

class EquipmentModel {
  String id;
  String name;
  int qty;
  DateTime time;
  int power;

  EquipmentModel({
    required this.id,
    required this.name,
    required this.qty,
    required this.time,
    required this.power,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'qty': qty,
      'time': time.millisecondsSinceEpoch,
      'power': power,
    };
  }

  factory EquipmentModel.fromMap(Map<String, dynamic> map) {
    return EquipmentModel(
      id: map['id'] as String,
      name: map['name'] as String,
      qty: map['qty'] as int,
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      power: map['power'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EquipmentModel.fromJson(String source) =>
      EquipmentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
