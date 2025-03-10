import 'dart:convert';

class RecoveryResponseModel {
  String message;
  String totpSecret;
  RecoveryResponseModel({
    required this.message,
    required this.totpSecret,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'totpSecret': totpSecret,
    };
  }

  factory RecoveryResponseModel.fromMap(Map<String, dynamic> map) {
    return RecoveryResponseModel(
      message: map['message'] as String,
      totpSecret: map['totp_secret'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecoveryResponseModel.fromJson(String source) =>
      RecoveryResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
