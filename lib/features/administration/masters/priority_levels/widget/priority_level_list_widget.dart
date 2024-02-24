import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/priority_levels/bloc/priority_level_bloc.dart';
import 'package:ecosys_safety/features/administration/masters/priority_levels/bloc/priority_level_event.dart';
import 'package:ecosys_safety/features/administration/masters/priority_levels/bloc/priority_level_state.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:ecosys_safety/features/theme/app_theme.dart';
import 'package:ecosys_safety/constants/app_strings.dart';
class PriorityLevelListWidget extends StatefulWidget {
  double dataTableWidth;

  PriorityLevelListWidget({
    super.key,
    required this.prioritylevelController,
    required this.prioritylevelUpdateController,
    required this.dataTableWidth,
  });

  final TextEditingController prioritylevelUpdateController;
  final TextEditingController prioritylevelController;

  @override
  State<StatefulWidget> createState() => _PriorityLevelListWidgetState();
}

class _PriorityLevelListWidgetState extends State<PriorityLevelListWidget> {
  DataGridController dataGridController = DataGridController();
  int selectedIndex = -1;
  double idBoxSize = 85.0;

  List<String> get tableColumns {
    return const [
      AppStrings.id,
      AppStrings.priorityLevel,
      AppStrings.priorityType,
      AppStrings.color,
      AppStrings.actions,
    ];
  }

  @override
  Widget build(BuildContext context) {
    //  widget.priorityTypeController.text = "";
    final themeData = Theme.of(context);
    return BlocBuilder<PriorityLevelBloc, PriorityLevelState>(
      builder: (context, state) {
        return DataTable(
            showCheckboxColumn: false,
            dividerThickness: 0,
            columns:  [
              DataColumn(
                  label: Text(
                tableColumns[0],
              )),
              DataColumn(label: Text(tableColumns[1])),
              DataColumn(label: Text(tableColumns[2])),
              DataColumn(
                  label: Text(
                tableColumns[3],
                textAlign: TextAlign.center,
              )),
              DataColumn(
                  label: Expanded(
                      child: Text(
                tableColumns[4],
                textAlign: TextAlign.center,
              ))),
            ],
            rows: List.generate(state.priorityLevelList.length, (index) {
              return _listItem(index, state);
            }),
            showBottomBorder: true,
            border: null,
            headingTextStyle: TextStyle(
                color: themeData.textColor,
                //fontFamily: 'Poppins,sans-serif',
                fontWeight: FontWeight.w700));
      },
    );
  }

  _listItem(int index, state) {
    String colorCode = state.priorityLevelList[index].color!;

    return DataRow.byIndex(
        color: MaterialStateColor.resolveWith((states) {
          return index == selectedIndex
              ? bluePageHeader
              : Colors.white; //make tha magic!
        }),
        index: index,
        cells: [
          DataCell(SizedBox(
            width: idBoxSize,
            child: Text("${index + 1}"),
          )),
          DataCell(
            state.priorityLevelList[index].name!.length > 30
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: (widget.dataTableWidth - 850 - idBoxSize) * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Tooltip(
                            message: "${state.priorityLevelList[index].name}",
                            preferBelow: false,
                            height: 30,
                            textAlign: TextAlign.justify,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: Text(
                              "${state.priorityLevelList[index].name}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    width: (widget.dataTableWidth - 750 - idBoxSize) * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "${state.priorityLevelList[index].name}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
          ),
          DataCell(state.priorityLevelList[index].priorityTypeName != null
              ? (state.priorityLevelList[index].priorityTypeName!.length > 30
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width:
                              (widget.dataTableWidth - 850 - idBoxSize) * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Tooltip(
                              message:
                                  "${state.priorityLevelList[index].priorityTypeName}",
                              preferBelow: false,
                              height: 30,
                              textAlign: TextAlign.justify,
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: Text(
                                "${state.priorityLevelList[index].priorityTypeName}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      width: (widget.dataTableWidth - 850 - idBoxSize) * 0.5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          "${state.priorityLevelList[index].priorityTypeName}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ))
              : SizedBox(
                  width: (widget.dataTableWidth - 750 - idBoxSize) * 0.5,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(""),
                  ),
                )),
          DataCell(Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  child: Container(
                      alignment: Alignment.centerLeft,
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        color: _getColor(colorCode),
                      ))),
              const SizedBox(
                width: 65,
              )
            ],
          )),
          DataCell(Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    widget.prioritylevelUpdateController.text =
                        state.priorityLevelList[index].name!;
                    context.read<PriorityLevelBloc>().add(PageChangeEvent(
                        page: 2,
                        priorityLevel: state.priorityLevelList[index]));
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.pen,
                    color: Colors.green,
                    size: 15,
                  )),
              spacery10,
              IconButton(
                  onPressed: () {
                    context.read<PriorityLevelBloc>().add(PageChangeEvent(
                        page: 3,
                        priorityLevel: state.priorityLevelList[index]));
                  },
                  icon: const FaIcon(FontAwesomeIcons.trashCan,
                      color: Colors.red, size: 15))
            ],
          )),
        ],
        selected: selectedIndex == index,
        onSelectChanged: (isSelected) {
          setState(() {
            selectedIndex = index;
          });
          context.read<PriorityLevelBloc>().add(PriorityLevelSelectedEvent(
              priorityLevel: state.priorityLevelList[index]));
          //state.subRegionList[index].isSelected = true;
        });
  }

  _getColor(String colorCode) {
    if (colorCode.startsWith("#")) {
      return Color(
          int.parse(colorCode.substring(1, 7), radix: 16) + 0xFF000000);
    } else {
      return Colors.black;
    }
  }
}
