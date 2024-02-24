import '/common_libraries.dart';
import 'widgets/widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late AuthBloc _authBloc;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_authBloc.state.authUser != null) {
      _goToDashboard();
    }
    super.didChangeDependencies();
  }

  void _goToDashboard() => GoRouter.of(context).go('/dashboard');

  void _checkAuthentication(AuthState state) {
    if (state is AuthAuthenticateSuccess) {
      _goToDashboard();
    } else if (state is AuthAuthenticateFailure) {
      _onLoginError(context, state.message);
    }
  }

  void _onLoginError(BuildContext context, String message) {
    final dialog = AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      desc: message,
      width: 460.0,
      btnOkText: 'OK',
      btnOkOnPress: () {},
    );

    dialog.show();
  }

  @override
  Widget build(BuildContext context) {
    return PublicMasterLayout(
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400.0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) => _checkAuthentication(state),
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Image.asset(
                                'assets/images/logo.png',
                                height: 16 * 7,
                                width: 200,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Welcome!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        spacery15,
                        const Text(
                          'Sign in to continue.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        spacery15,
                        FormBuilder(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 16 * 1.5),
                                child: UsernameField(),
                              ),
                              PasswordField(),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 16 * 2),
                                child: ForgotPasswordButton(),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 16),
                                child: LoginButton(_formKey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
