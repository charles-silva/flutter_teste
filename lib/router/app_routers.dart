class AppRoutes {
  static const root = '/';
  static const error = '/error';

// Authentication
  static const authentication = '/authentication';
  static const signIn = '$authentication/sign-in';
  static const verificationCode = '$authentication/verification-code';
  static const recoveryPassword = '$authentication/recovery-password';
  static const home = '/home';
}
