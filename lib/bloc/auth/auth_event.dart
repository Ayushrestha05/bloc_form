part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoadingEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

class RegisterEvent extends AuthEvent {
  final String username;
  final String password;

  RegisterEvent(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

class LogoutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class ClearDataEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
