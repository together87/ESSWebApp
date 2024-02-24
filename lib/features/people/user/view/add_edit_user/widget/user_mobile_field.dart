import '/common_libraries.dart';

class UserMobileField extends StatelessWidget {
  const UserMobileField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditUsersBloc, AddEditUsersState>(builder: (context, state) {
      return CustomTextNewField(
        hintText: 'Phone',
        initialValue: state.userPhone,
        validator: (value) {
          return null;
        },
        onChanged: (userPhone) {
          context.read<AddEditUsersBloc>().add(AddEditUserPhoneChanged(userPhone: userPhone));
        },
      );
    });
  }
}
