abstract class RegisterState {}

class PendingRegisterState extends RegisterState {}

class LoadingRegisterState extends RegisterState {}

class FailedRegisterState extends RegisterState {
  final String message;
  final int code;

  FailedRegisterState({
    required this.code,
    required this.message,
  });
}

class SuccessRegisterState extends RegisterState {}