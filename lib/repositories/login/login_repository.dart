import 'package:dartz/dartz.dart';
import 'package:flutter_dev_test/core/exceptions/app_error.dart';

import '../../models/login_response_model.dart';

abstract class LoginRepository {
  Future<Either<AppError, LoginResponse>> login(String username, String password, String totpCodigo);
}
