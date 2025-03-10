import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/core/helpers/constants.dart';
import 'package:flutter_dev_test/core/util/shared_preferences/local_storage.dart';
import 'package:flutter_dev_test/core/util/shared_preferences/shared_preferences_local_storage_imp.dart';
import 'package:flutter_dev_test/models/recovery_model.dart';
import 'package:flutter_dev_test/repositories/verification/verification_repository.dart';

import 'verification_event.dart';
import 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final VerificationRepository _repository;
  final LocalStorage? _localStorage; //usado para que seja possivel fazer mock para os testes.

  VerificationBloc({
    LocalStorage? localStorage,
    required VerificationRepository repository,
  })  : _repository = repository,
        _localStorage = localStorage ?? SharedPreferencesLocalStorageImp(),
        super(VerificationInitialState()) {
    on<VerificationRecoveryCodeEvent>(_onRecoveryCode);
    on<VerificationButtomEvent>(_setButtomState);
  }

  void _onRecoveryCode(VerificationRecoveryCodeEvent event, Emitter emit) async {
    emit(VerificationLoadingState());

    final user = await _localStorage?.read(AppConstants.REQUEST_TOTP_CODIGO);
    final userModel = user == null ? null : RecoveryModel.fromJson(user);

    final resultRecovery = await _repository.recoverySecret(
      userModel?.username ?? '',
      userModel?.password ?? '',
      event.code,
    );
    resultRecovery.fold(
      (l) {
        emit(VerificationErrorState('Código inválido'));
      },
      (r) {
        _localStorage?.write<String>(AppConstants.REQUEST_SECRET_CODIGO, r.totpSecret);
        final fullUserModel = userModel?.copyWith(totpCode: r.totpSecret);
        _localStorage?.write<String>(AppConstants.REQUEST_TOTP_CODIGO, fullUserModel?.toJson() ?? '');
        emit(VerificationSuccessState());
      },
    );
  }

  void _setButtomState(VerificationButtomEvent event, Emitter emit) {
    emit(VerificationButtomState(event.isEnable));
  }
}
