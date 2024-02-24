import '/common_libraries.dart';

class UserTitleField extends StatelessWidget {
  const UserTitleField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditUsersBloc, AddEditUsersState>(builder: (context, state) {
      return CustomTextNewField(
        hintText: 'User title',
        initialValue: state.userTitle,
        validator: (value) {
          return null;
        },
        onChanged: (userTitle) {
          context.read<AddEditUsersBloc>().add(AddEditUserTitleNameChanged(userTitle: userTitle));
        },
      );
    });
  }
}
