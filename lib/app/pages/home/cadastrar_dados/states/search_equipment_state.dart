abstract class SearchEquipmentState {}

class PendingSearchEquipmentState extends SearchEquipmentState {}

class LoadingSearchEquipmentState extends SearchEquipmentState {}

class SuccessSearchEquipmentState extends SearchEquipmentState {}

class FailedSearchEquipmentState extends SearchEquipmentState {}

// class FailedSearchEquipmentState extends SearchEquipmentState {
//   final String message;
//   final int code;

//   FailedSearchEquipmentState({
//     required this.code,
//     required this.message,
//   });
// }