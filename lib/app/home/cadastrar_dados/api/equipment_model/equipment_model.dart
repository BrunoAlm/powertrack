import 'dart:convert';

import 'package:collection/collection.dart';

import 'equipment.dart';

class EquipmentModel {
	Equipment? equipment;

	EquipmentModel({this.equipment});

	@override
	String toString() => 'EquipmentModel(equipment: $equipment)';

	factory EquipmentModel.fromEquipmentNameQty0TimeSpentPower(Map<String, dynamic> data) {
		return EquipmentModel(
			equipment: data['equipment'] == null
						? null
						: Equipment.fromEquipmentNameQty0TimeSpentPower(data['equipment'] as Map<String, dynamic>),
		);
	}



	Map<String, dynamic> toEquipmentNameQty0TimeSpentPower() => {
				'equipment': equipment?.toEquipmentNameQty0TimeSpentPower(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [EquipmentModel].
	factory EquipmentModel.fromJson(String data) {
		return EquipmentModel.fromEquipmentNameQty0TimeSpentPower(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [EquipmentModel] to a JSON string.
	String toJson() => json.encode(toEquipmentNameQty0TimeSpentPower());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! EquipmentModel) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toEquipmentNameQty0TimeSpentPower(), toEquipmentNameQty0TimeSpentPower());
	}

	@override
	int get hashCode => equipment.hashCode;
}
