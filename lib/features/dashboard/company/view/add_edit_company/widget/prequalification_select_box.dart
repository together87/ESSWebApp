import '/common_libraries.dart';

class PrequalificationSelectBox extends StatelessWidget {
  const PrequalificationSelectBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditCompanyBloc, AddEditCompanyState>(builder: (context, state) {
      // Map<String, Site> items = {}..addEntries(state.siteList.map((site) => MapEntry(site.name ?? '', site)));
      Map<String, Site> items = {};
      return CustomSingleSelect(items: items, hint: 'Prequalification Method', height: 52, selectedValue: state.prequalificationList.isEmpty ? null : state.prequalificationMethod, onChanged: (prequalificationMethod) {});
    });
  }
}
