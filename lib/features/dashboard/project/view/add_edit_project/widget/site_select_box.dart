import '/common_libraries.dart';

class SiteSelectBox extends StatelessWidget {
  final String label;
  const SiteSelectBox({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditProjectBloc, AddEditProjectState>(builder: (context, state) {
      Map<String, Site> items = {}..addEntries(state.siteList.map((site) => MapEntry(site.name ?? '', site)));
      return CustomSingleSelect(
          items: items,
          hint: 'Select Region to select site',
          height: 52,
          selectedValue: state.siteList.isEmpty ? null : state.site?.name,
          onChanged: (site) {
            context.read<AddEditProjectBloc>().add(AddEditProjectItemSiteChanged(site: site.value));
          });
    });
  }
}
