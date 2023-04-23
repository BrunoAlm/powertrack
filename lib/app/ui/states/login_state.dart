abstract class LoginState {}

class PendingLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class FailedLoginState extends LoginState {
  final String message;
  final int code;

  FailedLoginState({
    required this.code,
    required this.message,
  });
}

class SuccessLoginState extends LoginState {}
