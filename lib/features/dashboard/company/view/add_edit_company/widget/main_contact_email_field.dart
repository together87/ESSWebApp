import '/common_libraries.dart';

class MainContactEmailField extends StatelessWidget {
  const MainContactEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditCompanyBloc, AddEditCompanyState>(builder: (context, state) {
      return CustomTextNewField(
        hintText: AppStrings.mainContactEmailTypeHint,
        initialValue: state.mainContactEmail,
        validator: (value) {
          return null;
        },
        onChanged: (email) {
          context.read<AddEditCompanyBloc>().add(AddEditMainContactEmailChanged(email: email));
        },
      );
    });
  }
}
