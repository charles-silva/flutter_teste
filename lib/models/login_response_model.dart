import 'dart:convert';

class LoginResponse {
  String messsage;
  String status;

  LoginResponse({
    required this.messsage,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messsage': messsage,
      'status': status,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      messsage: map['message'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) => LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
