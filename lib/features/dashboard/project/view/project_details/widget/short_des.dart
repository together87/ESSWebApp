import '/common_libraries.dart';

class ShortDesField extends StatelessWidget {
  const ShortDesField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(builder: (context, state) {
      return CustomTextNewField(
        initialValue: state.shortDesText,
        hintText: 'Short Description(up to 100 characters)',
        minLines: 5,
        maxLines: 5,
        maxLength: 200,
        onChanged: (value) {
          context.read<ProjectDetailsBloc>().add(ProjectSupportingDescriptionChanged(description: value));
        },
      );
    });
  }
}
