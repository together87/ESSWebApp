// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  final EntityStatus status;
  final String message;
  final String title;
  final String emailValidationMessage;

  const ForgotPasswordState({
    this.status = EntityStatus.initial,
    this.message = '',
    this.title = '',
    this.emailValidationMessage = '',
  });

  @override
  List<Object> get props => [
        status,
        message,
        title,
        emailValidationMessage,
      ];

  ForgotPasswordState copyWith({
    EntityStatus? status,
    String? message,
    String? title,
    String? emailValidationMessage,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      message: message ?? this.message,
      title: title ?? this.title,
      emailValidationMessage: emailValidationMessage ?? this.emailValidationMessage,
    );
  }
}
