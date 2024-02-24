// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ResetPassword extends Equatable {
  final String email;
  final String oldPassword;
  final String newPassword;
  final String confirmNewPassword;

  const ResetPassword({
    required this.email,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  @override
  List<Object?> get props => [
        email,
        oldPassword,
        newPassword,
        confirmNewPassword,
      ];

  bool get isConfirmPassword => newPassword == confirmNewPassword;

  ResetPassword copyWith({
    String? email,
    String? oldPassword,
    String? newPassword,
    String? confirmNewPassword,
  }) {
    return ResetPassword(
      email: email ?? this.email,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
    };
  }

  String toJson() => json.encode(toMap());
}
