import '/common_libraries.dart';

class SiteDetailsItemView2 extends StatelessWidget {
  const SiteDetailsItemView2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SiteDetailsBloc, SiteDetailsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuditDetailItemView(
              label: AppStrings.timezone,
              content: state.sites?.timeZoneName ?? '',
            ),
            AuditDetailItemView(
              label: AppStrings.reference,
              content: state.sites?.referenceCode ?? '',
            ),
          ],
        );
      },
    );
  }
}
