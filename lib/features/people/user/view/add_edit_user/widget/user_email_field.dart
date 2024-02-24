import '/common_libraries.dart';

class UserEmailField extends StatelessWidget {
  const UserEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditUsersBloc, AddEditUsersState>(builder: (context, state) {
      return CustomTextNewField(
        hintText: 'Email',
        initialValue: state.email,
        validator: (value) {
          if (value == '') {
            return "";
          } else {
            return null;
          }
        },
        onChanged: (email) {
          context.read<AddEditUsersBloc>().add(AddEditUserEmailNameChanged(email: email));
        },
      );
    });
  }
}
