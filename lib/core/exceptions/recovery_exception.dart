import 'app_error.dart';

class RecoveryException extends AppError {
  final String message;

  RecoveryException(this.message);

  @override
  List<Object?> get props => [message];
}
