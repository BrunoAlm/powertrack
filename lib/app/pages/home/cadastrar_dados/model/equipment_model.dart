import 'dart:convert';
import 'package:flutter/material.dart';

class EquipmentModel {
  String id;
  String name;
  int qty;
  TimeOfDay? time;
  TextEditingController power;

  EquipmentModel({
    this.id = '0',
    required this.name,
    required this.qty,
    this.time = const TimeOfDay(hour: 0, minute: 0),
    required this.power,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'qty': qty,
      'time': (time!.hour.toString() + ":" + time!.minute.toString()),
      'power': power.text.trim(),
    };
  }

  factory EquipmentModel.fromMap(Map<String, dynamic> map) {
    return EquipmentModel(
      id: map['\$id'] as String,
      name: map['name'] as String,
      qty: map['qty'] as int,
      time: TimeOfDay(
        hour: int.parse(map['time'].toString().split(":").first),
        minute: int.parse(map['time'].toString().split(":").last),
      ),
      power: TextEditingController(text: map['power'] as String?),
    );
  }

  String toJson() => json.encode(toMap());

  factory EquipmentModel.fromJson(String source) =>
      EquipmentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
