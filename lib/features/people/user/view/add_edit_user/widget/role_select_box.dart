import '/common_libraries.dart';

class RoleSelectBox extends StatelessWidget {
  const RoleSelectBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditUsersBloc, AddEditUsersState>(
      builder: (context, state) {
        Map<String, Role> items = <String, Role>{}..addEntries(state.roleList.map((userRole) => MapEntry(userRole.name, userRole)));
        return CustomSingleSelect(
            items: items,
            hint: 'Select Role',
            height: 52,
            selectedValue: state.roleList.isEmpty ? null : state.role?.name,
            onChanged: (role) {
              context.read<AddEditUsersBloc>().add(AddEditUserRoleChanged(role: role.value));
            });
      },
    );
  }
}
