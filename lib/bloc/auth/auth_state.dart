part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String? loggedInUser;
  final LoginStatus loginStatus;
  final RegisterStatus registerStatus;

  AuthState(
      {this.loginStatus = LoginStatus.none,
      this.registerStatus = RegisterStatus.none,
      this.loggedInUser});

  AuthState copyWith(
      {String? loggedInUser,
      LoginStatus? loginStatus,
      RegisterStatus? registerStatus}) {
    return AuthState(
        loginStatus: loginStatus ?? this.loginStatus,
        registerStatus: registerStatus ?? this.registerStatus,
        loggedInUser: loggedInUser ?? this.loggedInUser);
  }

  @override
  List<Object?> get props => [loginStatus, registerStatus, loggedInUser];
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

enum LoginStatus { none, LoggedIn, Failed, AuthError, Started }

enum RegisterStatus { none, Registered, Failed, Exists, Started }
