import '/common_libraries.dart';

class ActionItemImagePicker extends StatelessWidget {
  const ActionItemImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMultiFilePicker(
      onSelect: (imageList) => context.read<ProjectDetailsBloc>().add(ProjectSupportingDocumentChanged(imageList: imageList.first)),
    );
  }
}
