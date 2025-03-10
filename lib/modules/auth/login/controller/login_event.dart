// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class LoginEvent {}

class LoginEventDoLogin extends LoginEvent {
  final String username;
  final String password;
  LoginEventDoLogin({
    required this.username,
    required this.password,
  });
}
