import '/common_libraries.dart';

class ProjectDetailsItemView2 extends StatelessWidget {
  const ProjectDetailsItemView2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuditDetailItemView(
              label: 'Site',
              content: state.project?.siteName ?? '',
            ),
            AuditDetailItemView(
              label: "Director",
              content: state.project?.directorName ?? '',
            ),
            AuditDetailItemView(
              label: "KPI",
              content: state.project?.kpi.toString() == 'true' ? "Yes" : "No",
            ),
          ],
        );
      },
    );
  }
}
