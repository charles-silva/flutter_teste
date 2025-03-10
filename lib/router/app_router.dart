// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_dev_test/modules/auth/login/ui/login_page.dart';
import 'package:flutter_dev_test/modules/auth/verification/ui/verification_page.dart';
import 'package:flutter_dev_test/router/app_routers.dart';
import 'package:go_router/go_router.dart';

import '../core/helpers/constants.dart';
import '../core/util/shared_preferences/shared_preferences_local_storage_imp.dart'
    show SharedPreferencesLocalStorageImp;
import '../models/recovery_model.dart';
import '../modules/home/ui/home_page.dart';

class AppRouter {
  GoRouter buildRouter() {
    return GoRouter(
      redirect: rootRedirect,
      routes: [
        GoRoute(
          path: AppRoutes.signIn,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: AppRoutes.verificationCode,
          builder: (context, state) => const VerificationPage(),
        ),
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),
      ],
    );
  }

  Future<String?> rootRedirect(context, state) async {
    // var isAuthenticated = await isUserAuthenticated();
    var user = await refreshModelTotp();
    if (user == null) {
      return AppRoutes.signIn;
    } else if (user.isAuth) {
      return AppRoutes.home;
    } else if (user.isComplete()) {
      return AppRoutes.signIn;
    } else if (user.totpCode.isEmpty) {
      return AppRoutes.verificationCode;
    }

    return AppRoutes.signIn;
  }

  Future<bool> isUserAuthenticated() async {
    var localStorage = SharedPreferencesLocalStorageImp();
    final totpCodigo = await localStorage.read(AppConstants.REQUEST_SECRET_CODIGO);
    return totpCodigo != null;
  }

  Future<RecoveryModel?> refreshModelTotp() async {
    var localStorage = SharedPreferencesLocalStorageImp();
    final user = await localStorage.read(AppConstants.REQUEST_TOTP_CODIGO);
    final userModel = user == null ? null : RecoveryModel.fromJson(user);
    return userModel;
  }
}
