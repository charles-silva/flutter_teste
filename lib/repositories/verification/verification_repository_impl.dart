import 'package:dartz/dartz.dart';

import '../../core/exceptions/app_error.dart';
import '../../core/exceptions/recovery_exception.dart';
import '../../core/rest_client/rest_client.dart';
import '../../core/rest_client/rest_client_exception.dart';
import '../../models/recovery_response_model.dart';
import 'verification_repository.dart';

class VerificationRepositoryImpl implements VerificationRepository {
  final RestClient _client;

  VerificationRepositoryImpl({
    required RestClient client,
  }) : _client = client;

  @override
  Future<Either<AppError, RecoveryResponseModel>> recoverySecret(String username, String password, String code) async {
    try {
      final result = await _client.post('/auth/recovery-secret', data: {
        'username': username,
        'password': password,
        'code': code,
      });
      return right(RecoveryResponseModel.fromMap(result.data!));
    } on RestClientException catch (e) {
      if (e.response?.statusCode == 401) {
        return left(RecoveryException('Código inválido'));
      }
      return left(ServerError(e.toString()));
    } catch (e) {
      return left(ServerError(e.toString()));
    }
  }
}
