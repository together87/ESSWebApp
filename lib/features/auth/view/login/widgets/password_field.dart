import '/common_libraries.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final TextEditingController _passwordController = TextEditingController();

  late LoginBloc _loginBloc;

  bool isPassword = true;

  @override
  void initState() {
    _loginBloc = context.read();
    super.initState();
  }

  void _onPasswordChange(String password) => _loginBloc.add(LoginPasswordChanged(password: password));

  void _validate() => _loginBloc.add(LoginValidationChecked());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => FormBuilderTextField(
              controller: _passwordController,
              name: 'password',
              cursorColor: AppColors.textgreyColor,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Password',
                labelStyle: TextStyle(color: Colors.blueGrey[900]),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.textgreyColor)),
                border: const OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: IconButton(
                    onPressed: () {
                      isPassword = !isPassword;
                      setState(() {});
                    },
                    icon: Icon(!isPassword ? Icons.visibility_off : Icons.remove_red_eye)),
              ),
              enableSuggestions: false,
              onSubmitted: (_) => _validate(),
              obscureText: isPassword,
              validator: FormBuilderValidators.required(),
              onChanged: (password) => _onPasswordChange(password.toString()),
            ));
  }
}
