import 'dart:convert';

class RecoveryModel {
  String username;
  String password;
  String totpCode;
  bool isAuth = false;
  RecoveryModel({
    required this.username,
    required this.password,
    required this.totpCode,
    required this.isAuth,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'totp_code': totpCode,
      'isAuth': isAuth,
    };
  }

  factory RecoveryModel.fromMap(Map<String, dynamic> map) {
    return RecoveryModel(
      username: map['username'] as String,
      password: map['password'] as String,
      totpCode: map['totp_code'] as String,
      isAuth: map['isAuth'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecoveryModel.fromJson(String source) => RecoveryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  RecoveryModel copyWith({
    String? username,
    String? password,
    String? totpCode,
    bool? isAuth,
  }) {
    return RecoveryModel(
      username: username ?? this.username,
      password: password ?? this.password,
      totpCode: totpCode ?? this.totpCode,
      isAuth: isAuth ?? this.isAuth,
    );
  }

  bool isComplete() {
    return username.isNotEmpty && password.isNotEmpty && totpCode.isNotEmpty;
  }
}
