import 'dart:io';

import '../../../../common_libraries.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final BuildContext context;

  late AuthRepository _authRepository;
  ForgotPasswordBloc(this.context) : super(const ForgotPasswordState()) {
    _authRepository = context.read();
    on<ForgotPasswordSubmitted>(_onForgotPasswordSubmitted);
    on<ForgotPasswordChanged>(_onForgotPasswordChanged);
  }

  Future<void> _onForgotPasswordChanged(
    ForgotPasswordChanged event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(emailValidationMessage: ''));
  }

  Future<void> _onForgotPasswordSubmitted(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    if (!Validation.isEmail(event.email)) {
      emit(state.copyWith(emailValidationMessage: FormValidationMessage.emailValidationMessage));
      return;
    }

    emit(state.copyWith(status: EntityStatus.loading));
    try {
      emit(state.copyWith(
        status: EntityStatus.success,
        title: "Success",
        message: 'Please check your email. If the email provided matched our records then we would have sent you an email with the link to reset the password.',
      ));
      // EntityResponse response = await _authRepository.forgotPassword(event.email);
      //
      // if (response.isSuccess) {
      //
      // }
    } on HttpException catch (e) {
      emit(state.copyWith(
        status: EntityStatus.failure,
        message: e.message,
        title: "Fail",
      ));
    }
  }
}
