// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class EquipmentModel {
  int id;
  String name;
  int qty;
  TimeOfDay? time; // TODO: Mudar o inteiro para DateTime
  TextEditingController power;

  EquipmentModel({
    required this.id,
    required this.name,
    required this.qty,
     this.time = const TimeOfDay(hour: 0, minute: 0),
    required this.power,
  });
}
