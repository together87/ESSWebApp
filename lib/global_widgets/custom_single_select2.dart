import 'package:select2dot1/select2dot1.dart';

import '/common_libraries.dart';

class CustomSelect2dot1 extends StatelessWidget {
  final String? title;
  final List<SingleCategoryModel> data;
  final bool isMultiSelect;
  final String hint;
  final bool avatarInSingleSelect;
  final bool extraInfoInSingleSelect;
  final bool extraInfoInDropdown;
  final ScrollController? scrollController;
  final bool isSearchable;
  final double width;
  final double height;
  final List<SingleItemCategoryModel>? selectedValue;
  final List<SingleItemCategoryModel>? initSelected;
  final Function(List<SingleItemCategoryModel>)? onChanged;

  const CustomSelect2dot1({super.key, this.title, required this.data, required this.isMultiSelect, required this.avatarInSingleSelect, required this.extraInfoInSingleSelect, required this.extraInfoInDropdown, required this.scrollController, this.hint = '', this.isSearchable = true, this.width = 400, this.height = 45, this.selectedValue, this.initSelected, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: width,
      ),
      child: Select2dot1(
        selectDataController: SelectDataController(
          data: data,
          isMultiSelect: false,
          initSelected: initSelected ??
              const [
                SingleItemCategoryModel(
                  nameSingleItem: 'Select the regions',
                ),
              ],
        ),
        isSearchable: isSearchable,
        pillboxSettings: PillboxSettings(
          constraints: BoxConstraints(minHeight: height),
          padding: const EdgeInsets.all(10),
          defaultDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: initSelected != null ? const Color(0xFF7e7e7e) : const Color(0xFF7e7e7e)),
          ),
          activeDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: initSelected != null ? const Color(0xFF7e7e7e) : const Color(0xFF7e7e7e)),
          ),
          hoverDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(255, 249, 249, 249),
            border: Border.all(color: initSelected != null ? const Color(0xFF7e7e7e) : const Color(0xFF7e7e7e)),
          ),
          focusDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(255, 199, 200, 201),
            border: Border.all(color: initSelected != null ? const Color(0xFF7e7e7e) : const Color(0xFF7e7e7e)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  spreadRadius: 1,
                  blurStyle: BlurStyle.solid,
                  color: Colors.black.withOpacity(0.1), //shadow for button
                  blurRadius: 1)
            ],
          ),
        ),
        dropdownOverlaySettings: DropdownOverlaySettings(
          maxHeight: 330,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            border: Border(),
            boxShadow: [],
          ),
          animationBuilder: (context, child, animationController) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: SizeTransition(
                sizeFactor: CurvedAnimation(
                  parent: animationController,
                  curve: Curves.easeInOutQuart,
                ),
                child: child,
              ),
            );
          },
        ),
        searchBarOverlayBuilder: (context, searchBarOverlayDetails) {
          return Container(
            height: 38,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            margin: const EdgeInsets.only(top: 9, left: 5, right: 5, bottom: 2),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 210, 219, 232),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: searchBarOverlayDetails.searchBarController,
                    focusNode: searchBarOverlayDetails.searchBarFocusNode,
                    cursorColor: Colors.black,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Color(0xFF202E50)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        categoryNameOverlaySettings: const CategoryNameOverlaySettings(
          constraints: BoxConstraints(minHeight: 38),
          textStyle: TextStyle(fontSize: 14, fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
        ),
        categoryItemOverlaySettings: CategoryItemOverlaySettings(
            constraints: const BoxConstraints(minHeight: 45),
            iconSize: 0.1,
            hoverDecoration: BoxDecoration(borderRadius: BorderRadius.zero, color: primaryColor.withOpacity(0.2)),
            defaultTextStyle: const TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
            ),
            selectedTextStyle: const TextStyle(fontSize: 14, fontFamily: 'Montserrat', color: Color(0xFF7e7e7e)),
            textPadding: const EdgeInsets.only(left: 20)),
        selectSingleSettings: const SelectSingleSettings(textStyle: TextStyle(fontSize: 14, fontFamily: 'Montserrat', color: Colors.black)),
        selectEmptyInfoSettings: SelectEmptyInfoSettings(
          text: hint,
          textStyle: const TextStyle(fontSize: 14, color: Color(0xFF7e7e7e)),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
