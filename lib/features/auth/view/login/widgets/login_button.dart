import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '/common_libraries.dart';

class LoginButton extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  const LoginButton(this.formKey, {super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  late AuthBloc _authBloc;
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _authBloc = context.read();
    _loginBloc = context.read();
    super.initState();
  }

  void _validate() => _loginBloc.add(LoginValidationChecked());

  void _login(LoginState state) {
    _authBloc.add(AuthAuthenticated(
        auth: Auth(
      email: state.username,
      password: state.password,
    )));
    _loginBloc.add(LoginValidationInited());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.valid != current.valid && current.valid,
      listener: (context, loginState) => _login(loginState),
      builder: (context, loginState) => BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) => SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (widget.formKey.currentState?.validate() ?? false) {
                _validate();
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 18),
            ),
            child: authState is AuthAuthenticateInProgress
                ? LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.white,
                    size: 26,
                  )
                : Text(
                    'Sign In',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
