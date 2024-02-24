import 'package:ecosys_safety/common_libraries.dart';
import 'package:select2dot1/select2dot1.dart';

class RegionSelect extends StatelessWidget {
  final ScrollController scrollController;

  const RegionSelect({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditSiteBloc, AddEditSiteState>(builder: (context, state) {
      List<SingleCategoryModel> data = state.regionsList.map((entry) => SingleCategoryModel(nameCategory: entry.name, singleItemCategoryList: entry.subRegions!.map((entry) => SingleItemCategoryModel(nameSingleItem: entry.name!, value: entry.id)).toList())).toList();

      List<SingleItemCategoryModel> selectedItem = [
        SingleItemCategoryModel(
          nameSingleItem: state.selectedSubregion == '' ? 'Select to regions' : state.selectedSubregion,
        ),
      ];

      return CustomSelect2dot1(
        data: data,
        isMultiSelect: false,
        avatarInSingleSelect: false,
        extraInfoInSingleSelect: false,
        extraInfoInDropdown: false,
        scrollController: scrollController,
        initSelected: selectedItem.first.nameSingleItem.contains("Select to regions") ? null : selectedItem,
        width: (MediaQuery.of(context).size.width - 400) * 0.5,
        height: 52,
        hint: "Select to regions again",
        onChanged: (regions) {
          if (regions.first.nameSingleItem != state.selectedSubregion && regions.first.value != null) {
            context.read<AddEditSiteBloc>().add(AddEditRegionSelectedEvent(subRegion: regions.first.nameSingleItem, subRegionId: regions.first.value));
          }
        },
      );
    });
  }
}
