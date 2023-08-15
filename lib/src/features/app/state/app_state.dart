abstract class AppState {}

class PendingAppState extends AppState {}

class LoadingAppState extends AppState {}

class FailedAppState extends AppState {
  final String message;
  final int code;

  FailedAppState({
    required this.code,
    required this.message,
  });
}

class SuccessAppState extends AppState {}
