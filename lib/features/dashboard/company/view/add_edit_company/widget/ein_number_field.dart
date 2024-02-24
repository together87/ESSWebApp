import '/common_libraries.dart';

class EINCompanyNumberField extends StatelessWidget {
  const EINCompanyNumberField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditCompanyBloc, AddEditCompanyState>(builder: (context, state) {
      return CustomTextNewField(
        hintText: AppStrings.einTypeHint,
        initialValue: state.einNumber,
        validator: (value) {
          return null;
        },
        onChanged: (number) {
          context.read<AddEditCompanyBloc>().add(AddEditCompanyEINNumberChanged(number: number));
        },
      );
    });
  }
}
