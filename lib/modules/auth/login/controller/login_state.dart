class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginInvalidTotpCodState extends LoginState {}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);
}
