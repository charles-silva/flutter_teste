// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_dev_test/core/exceptions/app_error.dart';
import 'package:flutter_dev_test/core/exceptions/login_exception.dart';
import 'package:flutter_dev_test/core/rest_client/rest_client.dart';
import 'package:flutter_dev_test/core/rest_client/rest_client_exception.dart';
import 'package:flutter_dev_test/repositories/login/login_repository.dart';

import '../../models/login_response_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final RestClient _client;

  LoginRepositoryImpl({
    required RestClient client,
  }) : _client = client;
  @override
  Future<Either<AppError, LoginResponse>> login(String username, String password, String totpCodigo) async {
    try {
      final result = await _client.post('/auth/login', data: {
        'username': username,
        'password': password,
        'totp_code': totpCodigo,
      });

      return right(LoginResponse.fromMap(result.data!));
    } on RestClientException catch (e) {
      if (e.response?.statusCode == 401) {
        return (e.response?.data['message'] == 'Invalid TOTP code')
            ? left(LoginInvalidTotpCodException())
            : left(LoginNotFoundException());
      }
      return left(ServerError(e.toString()));
    } catch (e) {
      return left(ServerError(e.toString()));
    }
  }
}
