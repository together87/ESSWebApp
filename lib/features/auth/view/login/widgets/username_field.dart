import '/common_libraries.dart';

class UsernameField extends StatefulWidget {
  const UsernameField({super.key});

  @override
  State<UsernameField> createState() => _UsernameFieldState();
}

class _UsernameFieldState extends State<UsernameField> {
  final TextEditingController _usernameController = TextEditingController();
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = context.read();
    super.initState();
  }

  void _onUsernameChange(String username) => _loginBloc.add(LoginUsernameChanged(username: username));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => FormBuilderTextField(
              name: 'username',
              cursorColor: AppColors.textgreyColor,
              controller: _usernameController,
              onChanged: (username) => _onUsernameChange(username.toString()),
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Username',
                labelStyle: TextStyle(color: Colors.blueGrey[900]),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.textgreyColor)),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              enableSuggestions: false,
              validator: FormBuilderValidators.required(),
            ));
  }
}
