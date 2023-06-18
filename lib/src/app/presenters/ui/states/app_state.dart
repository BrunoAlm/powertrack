abstract class AppState {}

class PendingAppState extends AppState {}

class LoadingAppState extends AppState {}

class FailedAppState extends AppState {
  final String error;

  FailedAppState({
    required this.error,
  });
}

class SuccessAppState extends AppState {}
