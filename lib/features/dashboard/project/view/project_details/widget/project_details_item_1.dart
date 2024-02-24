import 'package:ecosys_safety/common_libraries.dart';

class ProjectDetailsItemView1 extends StatelessWidget {
  const ProjectDetailsItemView1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(builder: (context, state) {
      return Column(
        children: [
          AuditDetailItemView(
            label: 'Project Name',
            content: state.project?.projectName ?? '',
          ),
          AuditDetailItemView(
            label: 'Project Number',
            content: state.project?.proNumber ?? '',
          ),
          AuditDetailItemView(
            label: "Reference:",
            content: state.project?.projectReference ?? '',
          ),
          AuditDetailItemView(
            label: "Active",
            content: state.project?.active.toString() == 'true' ? "Yes" : "No",
          ),
        ],
      );
    });
  }
}
