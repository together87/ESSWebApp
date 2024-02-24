import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../common_libraries.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late TextEditingController _emailController;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PublicMasterLayout(
      body: Align(
        alignment: Alignment.center,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state.status.isSuccess) {
                      CustomNotification(
                        context: context,
                        notifyType: NotifyType.success,
                        content: state.message,
                        title: state.title,
                      ).showNotification();
                      _emailController.clear();
                      context.go('/login');
                    } else if (state.status.isFailure) {
                      final dialog = AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        desc: state.message,
                        width: 460.0,
                        btnOkText: 'OK',
                        btnOkOnPress: () {},
                      );

                      dialog.show();
                    }
                  },
                  listenWhen: (previous, current) => previous != current,
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
                        Center(
                          child: PhosphorIcon(
                            PhosphorIcons.keyhole(),
                            size: 60,
                          ),
                        ),
                        spacery15,
                        const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        spacery15,
                        FormBuilder(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: FormBuilderTextField(
                            name: 'email',
                            cursorColor: AppColors.textgreyColor,
                            controller: _emailController,
                            onChanged: (_) => context.read<ForgotPasswordBloc>().add(ForgotPasswordChanged()),
                            onSubmitted: (_) => context.read<ForgotPasswordBloc>().add(ForgotPasswordSubmitted(email: _emailController.text)),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Email',
                              labelStyle: TextStyle(color: Colors.blueGrey[900]),
                              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.textgreyColor)),
                              border: const OutlineInputBorder(),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),
                            enableSuggestions: false,
                            validator: FormBuilderValidators.required(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 16 * 1.5),
                          child: Text(
                            'We will send you an email with the link to reset the password. This email has to match the email you use for logging into the system.',
                            style: textNormal14,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  context.read<ForgotPasswordBloc>().add(ForgotPasswordSubmitted(email: _emailController.text));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 18),
                              ),
                              child: state.status.isLoading
                                  ? LoadingAnimationWidget.staggeredDotsWave(
                                      color: Colors.white,
                                      size: 26,
                                    )
                                  : Text(
                                      'Submit',
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
                        Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => context.go('/login'),
                            child: const Text(
                              'Back to Login',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        spacery30,
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
