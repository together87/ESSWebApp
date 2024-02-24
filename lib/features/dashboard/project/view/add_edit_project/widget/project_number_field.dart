import '/common_libraries.dart';

class ProjectNumberField extends StatelessWidget {
  const ProjectNumberField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditProjectBloc, AddEditProjectState>(builder: (context, state) {
      return CustomTextNewField(
        hintText: AppStrings.projectNumberHint,
        initialValue: state.number,
        maxLength: 50,
        isNumber: true,
        validator: (value) {
          if (value == '') {
            return "";
          } else {
            return null;
          }
        },
        onChanged: (number) {
          context.read<AddEditProjectBloc>().add(AddEditProjectNumberChanged(number: number));
        },
      );
    });
  }
}
