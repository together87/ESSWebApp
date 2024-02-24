import '/common_libraries.dart';

class UserLastNameField extends StatelessWidget {
  const UserLastNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditUsersBloc, AddEditUsersState>(builder: (context, state) {
      return CustomTextNewField(
        hintText: 'Last name',
        initialValue: state.lastName,
        validator: (value) {
          if (value == '') {
            return "";
          } else {
            return null;
          }
        },
        onChanged: (lastName) {
          context.read<AddEditUsersBloc>().add(AddEditUserLastNameChanged(lastName: lastName));
        },
      );
    });
  }
}
