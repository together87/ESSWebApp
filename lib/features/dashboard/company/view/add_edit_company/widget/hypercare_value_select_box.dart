import '/common_libraries.dart';

class HypercareValueSelectBox extends StatelessWidget {
  const HypercareValueSelectBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditCompanyBloc, AddEditCompanyState>(builder: (context, state) {
      // Map<String, Site> items = {}..addEntries(state.siteList.map((site) => MapEntry(site.name ?? '', site)));
      Map<String, Site> items = {};
      return CustomSingleSelect(items: items, hint: 'Hypercare Value', height: 52, selectedValue: state.hypercareValueList.isEmpty ? null : state.hypercareValue, onChanged: (hypercareValue) {});
    });
  }
}
