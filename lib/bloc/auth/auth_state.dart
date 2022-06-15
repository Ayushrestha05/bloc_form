part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadingState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NotLoggedInState extends AuthState {
  @override
  List<Object?> get props => [];
}

class LoggedInState extends AuthState {
  final String username;

  LoggedInState(this.username);

  @override
  List<Object?> get props => [username];
}

class FailureAlertState extends AuthState {
  final String errorMessage;

  FailureAlertState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class WaitingState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegisteredState extends AuthState {
  @override
  List<Object?> get props => [];
}
