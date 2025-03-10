import 'package:dartz/dartz.dart';
import 'package:flutter_dev_test/core/exceptions/app_error.dart';
import 'package:flutter_dev_test/models/recovery_response_model.dart';

abstract class VerificationRepository {
  Future<Either<AppError, RecoveryResponseModel>> recoverySecret(String username, String password, String code);
}
