import '/common_libraries.dart';

class MainContactPhoneField extends StatelessWidget {
  const MainContactPhoneField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditCompanyBloc, AddEditCompanyState>(builder: (context, state) {
      return CustomTextNewField(
        hintText: AppStrings.mainContactPhoneTypeHint,
        initialValue: state.mainContactPhone,
        maxLength: 10,
        validator: (value) {
          return null;
        },
        onChanged: (phone) {
          context.read<AddEditCompanyBloc>().add(AddEditMainContactPhoneChanged(phone: phone));
        },
      );
    });
  }
}
