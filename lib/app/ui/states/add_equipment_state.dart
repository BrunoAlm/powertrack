abstract class AddEquipmentState {}

class PendingAddEquipmentState implements AddEquipmentState {}

class SuccessAddEquipmentState implements AddEquipmentState {}

class FailedAddEquipmentState implements AddEquipmentState {
  final String message;
  final int code;

  FailedAddEquipmentState({
    required this.code,
    required this.message,
  });
}
