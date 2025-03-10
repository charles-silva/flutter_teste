import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/core/exceptions/login_exception.dart';
import 'package:flutter_dev_test/core/helpers/constants.dart';
import 'package:flutter_dev_test/core/util/shared_preferences/local_storage.dart';
import 'package:flutter_dev_test/core/util/shared_preferences/shared_preferences_local_storage_imp.dart';
import 'package:flutter_dev_test/models/recovery_model.dart';
import 'package:flutter_dev_test/modules/auth/login/controller/login_event.dart';
import 'package:flutter_dev_test/modules/auth/login/controller/login_state.dart';
import 'package:flutter_dev_test/repositories/login/login_repository.dart';
import 'package:otp/otp.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _repository;
  final LocalStorage? _localStorage; //

  LoginBloc({
    LocalStorage? localStorage,
    required LoginRepository repository,
  })  : _repository = repository,
        _localStorage = localStorage ?? SharedPreferencesLocalStorageImp(),
        super(LoginInitialState()) {
    on<LoginEventDoLogin>(_onLogin);
    localStorage ?? SharedPreferencesLocalStorageImp();
  }
  Future<void> _onLogin(LoginEventDoLogin event, Emitter emit) async {
    emit(LoginLoadingState());

    final secret = await _localStorage?.read(AppConstants.REQUEST_SECRET_CODIGO);
    final user = await _localStorage?.read(AppConstants.REQUEST_TOTP_CODIGO);
    final userModel = user == null ? null : RecoveryModel.fromJson(user);

    final totpCodigo = secret != null ? generateTOTP(secret) : '';

    final loginResult = await _repository.login(
      event.username,
      event.password,
      totpCodigo,
    );

    loginResult.fold(
      (l) {
        if (l is LoginNotFoundException) {
          emit(LoginErrorState('Credenciais inválidas'));
        } else if (l is LoginInvalidTotpCodException) {
          _localStorage?.write<String>(
              AppConstants.REQUEST_TOTP_CODIGO,
              RecoveryModel(
                username: event.username,
                password: event.password,
                totpCode: '',
                isAuth: false,
              ).toJson());
          emit(LoginInvalidTotpCodState());
        } else {
          emit(LoginErrorState('Erro ao realizar login'));
        }
      },
      (r) {
        final fullUserModel = userModel?.copyWith(isAuth: true);
        _localStorage?.write<String>(AppConstants.REQUEST_TOTP_CODIGO, fullUserModel?.toJson() ?? '');
        emit(LoginSuccessState());
      },
    );
  }

  String generateTOTP(String secret) {
    return OTP.generateTOTPCodeString(
      secret,
      DateTime.now().millisecondsSinceEpoch,
      interval: 30,
      algorithm: Algorithm.SHA1,
      isGoogle: true,
    );
  }
}
