import '/common_libraries.dart';

class SiteDetailsItemView3 extends StatelessWidget {
  const SiteDetailsItemView3({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SiteDetailsBloc, SiteDetailsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuditDetailItemView(
              label: AppStrings.jsaMethod,
              content: state.sites?.jsaMethod ?? '',
            ),
            AuditDetailItemView(label: AppStrings.jsaActiveStauts, content: state.sites?.jsaArchiveReview.toString() == "true" ? "Yes" : "No"),
          ],
        );
      },
    );
  }
}
