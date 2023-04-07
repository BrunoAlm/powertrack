import 'dart:convert';

import 'package:collection/collection.dart';

class Equipment {
	String? name;
	int? qty;
	String? timeSpent;
	int? power;

	Equipment({this.name, this.qty, this.timeSpent, this.power});

	@override
	String toString() {
		return 'Equipment(name: $name, qty: $qty, timeSpent: $timeSpent, power: $power)';
	}

	factory Equipment.fromEquipmentNameQty0TimeSpentPower(Map<String, dynamic> data) {
		return Equipment(
			name: data['name'] as String?,
			qty: data['qty'] as int?,
			timeSpent: data['timeSpent'] as String?,
			power: data['power'] as int?,
		);
	}



	Map<String, dynamic> toEquipmentNameQty0TimeSpentPower() => {
				'name': name,
				'qty': qty,
				'timeSpent': timeSpent,
				'power': power,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Equipment].
	factory Equipment.fromJson(String data) {
		return Equipment.fromEquipmentNameQty0TimeSpentPower(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Equipment] to a JSON string.
	String toJson() => json.encode(toEquipmentNameQty0TimeSpentPower());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Equipment) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toEquipmentNameQty0TimeSpentPower(), toEquipmentNameQty0TimeSpentPower());
	}

	@override
	int get hashCode =>
			name.hashCode ^
			qty.hashCode ^
			timeSpent.hashCode ^
			power.hashCode;
}
