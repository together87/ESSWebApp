import '/common_libraries.dart';

class UserFirstNameField extends StatelessWidget {
  const UserFirstNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditUsersBloc, AddEditUsersState>(builder: (context, state) {
      return CustomTextNewField(
        hintText: 'First name',
        initialValue: state.firstName,
        validator: (value) {
          if (value == '') {
            return "";
          } else {
            return null;
          }
        },
        onChanged: (firstName) {
          context.read<AddEditUsersBloc>().add(AddEditUserFirstNameChanged(firstName: firstName));
        },
      );
    });
  }
}
