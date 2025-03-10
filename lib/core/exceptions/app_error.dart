import 'package:equatable/equatable.dart';

abstract class AppError extends Equatable implements Exception {}

class ServerError extends AppError {
  final String message;

  ServerError(this.message);

  @override
  List<Object?> get props => [message];
}
