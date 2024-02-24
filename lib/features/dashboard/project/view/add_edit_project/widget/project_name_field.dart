import '/common_libraries.dart';

class ProjectNameField extends StatelessWidget {
  const ProjectNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditProjectBloc, AddEditProjectState>(builder: (context, state) {
      return CustomTextNewField(
        hintText: AppStrings.projectTypeHint,
        initialValue: state.name,
        maxLength: 50,
        validator: (value) {
          if (value == '') {
            return "";
          } else {
            return null;
          }
        },
        onChanged: (name) {
          context.read<AddEditProjectBloc>().add(AddEditProjectNameChanged(name: name));
        },
      );
    });
  }
}
