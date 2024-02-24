import 'package:ecosys_safety/common_libraries.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => context.go('/forgot_password'),
        child: Text(
          'Forgot password?',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: themeData.textColor,
          ),
        ),
      ),
    );
  }
}
