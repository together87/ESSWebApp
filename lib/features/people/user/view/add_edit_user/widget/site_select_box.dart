import '/common_libraries.dart';

class SiteSelectBox extends StatelessWidget {
  const SiteSelectBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditUsersBloc, AddEditUsersState>(builder: (context, state) {
      Map<String, Site> items = {}..addEntries(state.siteList.map((site) => MapEntry(site.name ?? '', site)));
      return CustomSingleSelect(
          items: items,
          hint: 'Select site',
          height: 52,
          selectedValue: state.siteList.isEmpty ? null : state.site?.name,
          onChanged: (site) {
            context.read<AddEditUsersBloc>().add(AddEditUserItemSiteChanged(site: site.value));
          });
    });
  }
}
