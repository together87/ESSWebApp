import 'package:dropdown_button2/dropdown_button2.dart';

import '/common_libraries.dart';

class CustomSingleSelect extends StatefulWidget {
  final Map<String, dynamic> items;
  final String? selectedValue;
  final String? hint;
  final ValueChanged<MapEntry<String, dynamic>> onChanged;
  final bool disabled;
  final bool isBorderStaus;
  final bool isSearchable;
  final double width;
  final double height;
  const CustomSingleSelect({
    super.key,
    required this.items,
    this.selectedValue,
    this.hint,
    required this.onChanged,
    this.disabled = false,
    this.isBorderStaus = true,
    this.isSearchable = true,
    this.width = double.infinity,
    this.height = 40,
  });

  @override
  State<CustomSingleSelect> createState() => _CustomSingleSelectState();
}

class _CustomSingleSelectState<T> extends State<CustomSingleSelect> {
  final TextEditingController textEditingController = TextEditingController();
  String? value;
  bool boxShadowFlag = false;
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          dropdownSearchData: widget.isSearchable
              ? DropdownSearchData<String>(
                  searchController: textEditingController,
                  searchInnerWidgetHeight: 40,
                  searchInnerWidget: Container(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                        hintText: 'Search...',
                        hintStyle: TextStyle(fontSize: 14, color: themeData.textColor),
                        border: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.textgreyColor)),
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.textgreyColor)),
                      ),
                      style: TextStyle(fontSize: 14, color: themeData.textColor),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return (item.value.toString().toLowerCase().contains(searchValue.toLowerCase()));
                  },
                )
              : null,
          isExpanded: true,
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              textEditingController.clear();
              setState(() {
                boxShadowFlag = false;
              });
            } else {
              setState(() {
                boxShadowFlag = true;
              });
            }
          },
          hint: widget.hint == null
              ? null
              : Text(
                  widget.disabled ? widget.selectedValue ?? '' : widget.hint ?? '',
                  style: textNormal14.copyWith(color: themeData.textColor),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(10),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          items: (widget.disabled ? <String>[] : widget.items.keys.map((entry) => entry).toList())
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 14, color: themeData.textColor),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
              )
              .toList(),
          value: widget.selectedValue == null
              ? null
              : widget.selectedValue!.isEmpty
                  ? null
                  : !widget.items.keys.contains(widget.selectedValue)
                      ? null
                      : widget.selectedValue,
          onChanged: (val) {
            MapEntry<String, dynamic> entry = MapEntry<String, dynamic>(val!, widget.items[val]! as dynamic);
            widget.onChanged(entry);
            textEditingController.clear();
          },
          buttonStyleData: ButtonStyleData(
            height: 36,
            decoration: BoxDecoration(
              borderRadius: widget.isBorderStaus
                  ? BorderRadius.circular(5)
                  : const BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
              boxShadow: boxShadowFlag
                  ? <BoxShadow>[
                      BoxShadow(
                          spreadRadius: 1,
                          blurStyle: BlurStyle.solid,
                          color: Colors.black.withOpacity(0.1), //shadow for button
                          blurRadius: 1) //blur radius of shadow
                    ]
                  : [],
              border: Border.all(color: AppColors.textgreyColor),
              color: widget.disabled ? const Color(0xfff9fafb) : null,
            ),
          ),
          selectedItemBuilder: (BuildContext context) {
            return (widget.disabled ? <String>[] : widget.items.keys.map((entry) => entry).toList()).map<Widget>((String item) {
              return Container(
                alignment: Alignment.centerLeft,
                constraints: const BoxConstraints(minWidth: 100),
                child: Text(item, style: textNormal14.copyWith(color: themeData.textColor)),
              );
            }).toList();
          },
          menuItemStyleData: MenuItemStyleData(
            height: 40,
            overlayColor: MaterialStateProperty.resolveWith(getColor),
            selectedMenuItemBuilder: (context, child) {
              return Container(
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return primaryColor.withOpacity(0.2);
    }
    return Colors.white;
  }
}
