import 'package:equatable/equatable.dart';

class LoginResponseItem extends Equatable {
  final String token;
  final String refreshToken;

  const LoginResponseItem({
    required this.token,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [
        token,
        refreshToken,
      ];

  @override
  bool get stringify => true;

  factory LoginResponseItem.fromJson(Map<String, dynamic> json) {
    return LoginResponseItem(
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'token': token,
        'refreshToken': refreshToken,
      }
    };
  }
}
