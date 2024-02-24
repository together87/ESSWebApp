import '/common_libraries.dart';

class MainContactNameField extends StatelessWidget {
  const MainContactNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditCompanyBloc, AddEditCompanyState>(builder: (context, state) {
      return CustomTextNewField(
        hintText: AppStrings.mainContactNameTypeHint,
        initialValue: state.mainContactName,
        validator: (value) {
          return null;
        },
        onChanged: (name) {
          context.read<AddEditCompanyBloc>().add(AddEditMainContactNameChanged(name: name));
        },
      );
    });
  }
}
