/*
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/common_libraries.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  static ImageProvider backgroundImage = const NetworkImage(
      'https://images.unsplash.com/photo-1536532184021-da5392b55da1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80');

  late TextEditingController _emailController;
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confrimPasswordController;

  bool isPassword = true;

  @override
  void initState() {
    _emailController = TextEditingController();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confrimPasswordController = TextEditingController();

    String pageURL = Uri.base.toString();
    final formattedURL = pageURL.replaceFirst('#', '');
    Uri uri = Uri.parse(formattedURL);

    Map<String, String> queryParams = uri.queryParameters;
    String? userEmail = queryParams['email'];
    _emailController.text = userEmail.toString() ?? '';
    context
        .read<ResetPasswordBloc>()
        .add(ResetPasswordEmailChanged(email: userEmail.toString()));

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confrimPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter:
                const ColorFilter.mode(Colors.blueGrey, BlendMode.dstATop),
            image: backgroundImage,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 500,
                margin: const EdgeInsets.all(50),
                padding: const EdgeInsets.all(60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: insety30,
                          child: SvgPicture.asset(
                            'assets/images/logo.svg',
                            semanticsLabel: 'Logo',
                            width: 300,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextField(
                              readOnly: true,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey[900],
                              ),
                              controller: _emailController,
                              onChanged: (email) => context
                                  .read<ResetPasswordBloc>()
                                  .add(ResetPasswordEmailChanged(email: email)),
                              decoration: InputDecoration(
                                filled: true,
                                focusColor: const Color(0xfffbfafb),
                                fillColor: const Color(0xffeae8ea),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixIcon: Icon(
                                  Icons.person_2,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                                hintText: 'Email',
                              ),
                            ),
                            Padding(
                              padding: insetx10.copyWith(top: 5, bottom: 10),
                              child: Text(
                                state.emailValidationMessage,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            spacery10,
                            TextField(
                              controller: _oldPasswordController,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey[900],
                              ),
                              onChanged: (password) => context
                                  .read<ResetPasswordBloc>()
                                  .add(ResetPasswordOldPasswordChanged(
                                      password: password)),
                              decoration: InputDecoration(
                                filled: true,
                                focusColor: const Color(0xfffbfafb),
                                fillColor: const Color(0xffeae8ea),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock_open_outlined,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                                hintText: 'Temporary Password',
                              ),
                              obscureText: true,
                            ),
                            Padding(
                              padding: insetx10.copyWith(top: 5, bottom: 10),
                              child: Text(
                                state.oldPasswordValidationMessage,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            spacery10,
                            TextField(
                              controller: _newPasswordController,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey[900],
                              ),
                              onChanged: (password) => context
                                  .read<ResetPasswordBloc>()
                                  .add(ResetPasswordPasswordChanged(
                                      password: password)),
                              decoration: InputDecoration(
                                filled: true,
                                focusColor: const Color(0xfffbfafb),
                                fillColor: const Color(0xffeae8ea),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock_open_outlined,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                                suffixIcon: state.confirmValidationMessage ==
                                        'Passwords are not same.'
                                    ? IconButton(
                                        icon: Icon(
                                          isPassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () => setState(() {
                                          isPassword = !isPassword;
                                        }),
                                      )
                                    : const SizedBox(),
                                hintText: 'New Password',
                              ),
                              obscureText: isPassword,
                            ),
                            Padding(
                              padding: inset20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ValidationItemView(
                                    primaryLabel: '8 characters long',
                                    secondaryLabel: 'Must be at least',
                                    success: state.maxLengthValidated,
                                  ),
                                  ValidationItemView(
                                    primaryLabel: '1 special character',
                                    secondaryLabel: 'Must contain at least',
                                    success: state.specialCharValidated,
                                  ),
                                  ValidationItemView(
                                    primaryLabel: '1 uppercase letter',
                                    secondaryLabel: 'Must contain at least',
                                    success: state.uppercaseCharValidated,
                                  ),
                                ],
                              ),
                            ),
                            TextField(
                              controller: _confrimPasswordController,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey[900],
                              ),
                              onChanged: (password) => context
                                  .read<ResetPasswordBloc>()
                                  .add(ResetPasswordConfirmPasswordChanged(
                                      password: password)),
                              decoration: InputDecoration(
                                filled: true,
                                focusColor: const Color(0xfffbfafb),
                                fillColor: const Color(0xffeae8ea),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock_open_outlined,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                                hintText: 'Confirm Password',
                              ),
                              obscureText: isPassword,
                            ),
                            Padding(
                              padding: insetx10.copyWith(top: 5, bottom: 10),
                              child: Text(
                                state.confirmValidationMessage,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: insety10,
                              child: BlocListener<ResetPasswordBloc,
                                  ResetPasswordState>(
                                listener: (context, state) {
                                  if (state.status.isSuccess) {
                                    CustomNotification(
                                      context: context,
                                      notifyType: NotifyType.success,
                                      content: state.message,
                                    ).showNotification();

                                    context.go('/login');

                                    _confrimPasswordController.clear();
                                    _emailController.clear();
                                    _newPasswordController.clear();
                                    _oldPasswordController.clear();
                                  } else if (state.status.isFailure) {
                                    CustomNotification(
                                      context: context,
                                      notifyType: NotifyType.error,
                                      content: state.message,
                                    ).showNotification();
                                  }
                                },
                                listenWhen: (previous, current) =>
                                    previous.status != current.status,
                                child: ElevatedButton(
                                  onPressed: () => context
                                      .read<ResetPasswordBloc>()
                                      .add(ResetPasswordReset()),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff68767b),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 24),
                                  ),
                                  child: state.status.isLoading
                                      ? LoadingAnimationWidget
                                          .staggeredDotsWave(
                                          color: Colors.white,
                                          size: 26,
                                        )
                                      : Text(
                                          'Reset Password',
                                          style: GoogleFonts.amaranth(
                                            textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              letterSpacing: 4,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            spacery10,
                            Container(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => context.go('/login'),
                                child: const Text(
                                  'Login?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            spacery30,
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ValidationItemView extends StatelessWidget {
  final bool success;
  final String secondaryLabel;
  final String primaryLabel;
  const ValidationItemView({
    super.key,
    required this.success,
    required this.secondaryLabel,
    required this.primaryLabel,
  });

  Color _getColor() => success ? successColor : Colors.red;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PhosphorIcon(
          success
              ? PhosphorIcons.regular.checkCircle
              : PhosphorIcons.regular.xCircle,
          color: _getColor(),
        ),
        spacerx5,
        RichText(
          text: TextSpan(
            text: '$secondaryLabel ',
            style: TextStyle(color: _getColor()),
            children: [
              TextSpan(
                text: primaryLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
*/
