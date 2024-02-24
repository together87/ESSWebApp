import '/common_libraries.dart';

class CompanyNameField extends StatelessWidget {
  const CompanyNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditCompanyBloc, AddEditCompanyState>(builder: (context, state) {
      return CustomTextNewField(
        hintText: AppStrings.companyTypeHint,
        initialValue: state.companyName,
        validator: (value) {
          if (value == '') {
            return "";
          } else {
            return null;
          }
        },
        onChanged: (name) {
          context.read<AddEditCompanyBloc>().add(AddEditCompanyNameChanged(name: name));
        },
      );
    });
  }
}
