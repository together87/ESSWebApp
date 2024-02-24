import '/common_libraries.dart';

class ProjectDetailsItemView3 extends StatelessWidget {
  const ProjectDetailsItemView3({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuditDetailItemView(
              label: "Created By",
              content: "--",
            ),
            const AuditDetailItemView(
              label: "Region",
              content: "--",
            ),
            AuditDetailItemView(
              label: "Peer Audit Required",
              content: state.project?.peerReviewRequired.toString() == 'true' ? "Yes" : "No",
            ),
          ],
        );
      },
    );
  }
}
