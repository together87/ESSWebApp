import '/common_libraries.dart';

class ProjectReferenceField extends StatelessWidget {
  const ProjectReferenceField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditProjectBloc, AddEditProjectState>(builder: (context, state) {
      return CustomTextNewField(
        hintText: AppStrings.projectReferenceHint,
        initialValue: state.projectReference,
        maxLength: 50,
        isNumber: true,
        validator: (value) {
          return null;
        },
        onChanged: (projectReference) {
          context.read<AddEditProjectBloc>().add(AddEditProjectReferenceChanged(projectReference: projectReference));
        },
      );
    });
  }
}
