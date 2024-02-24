import 'package:ecosys_safety/common_libraries.dart';

class SiteDetailsItemView1 extends StatelessWidget {
  const SiteDetailsItemView1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SiteDetailsBloc, SiteDetailsState>(builder: (context, state) {
      return Column(
        children: [
          AuditDetailItemView(
            label: AppStrings.siteCode,
            content: state.sites?.siteCode ?? '',
          ),
          AuditDetailItemView(
            label: AppStrings.region,
            content: state.sites?.regionName ?? '',
          ),
        ],
      );
    });
  }
}
