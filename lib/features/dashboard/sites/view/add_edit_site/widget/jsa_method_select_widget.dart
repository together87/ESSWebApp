import 'package:ecosys_safety/common_libraries.dart';

class JSAMethodSelect extends StatelessWidget {
  const JSAMethodSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditSiteBloc, AddEditSiteState>(builder: (context, state) {
      Map<String, JsaMethod> items = {}..addEntries(state.jsaMethodList.map((jsaMethod) => MapEntry(jsaMethod.name ?? '', jsaMethod)));
      return CustomSingleSelect(
          items: items,
          hint: 'Select ${AppStrings.jsaMethod}',
          height: 52,
          isBorderStaus: true,
          selectedValue: state.selectedJsaMethod == null
              ? ''
              : state.selectedJsaMethod?.name == "null"
                  ? ''
                  : state.selectedJsaMethod?.name,
          onChanged: (jsaMethod) {
            context.read<AddEditSiteBloc>().add(AddEditJsaMethodSelectedEvent(jsaMethod: jsaMethod.value));
          });
    });
  }
}
