import 'app_error.dart';

class LoginException extends AppError {
  final String message;

  LoginException(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginNotFoundException extends AppError {
  LoginNotFoundException();

  @override
  List<Object?> get props => [];
}

class LoginInvalidTotpCodException extends AppError {
  LoginInvalidTotpCodException();

  @override
  List<Object?> get props => [];
}
