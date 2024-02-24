import 'package:ecosys_safety/common_libraries.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:ecosys_safety/features/theme/app_theme.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/bloc/priority_type_event.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/bloc/priority_type_state.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/data/model/priorityType.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/bloc/priority_type_bloc.dart';
import 'package:ecosys_safety/constants/app_strings.dart';
class PriorityTypeList extends StatefulWidget {
  double dataTableWidth;
  PriorityTypeList(
      {super.key,
      required this.priorityTypeController,
      required this.priorityTypeUpdateController,
      required this.dataTableWidth});

  final TextEditingController priorityTypeUpdateController;
  final TextEditingController priorityTypeController;

  @override
  State<StatefulWidget> createState() => _PriorityTypeListState();
}

class _PriorityTypeListState extends State<PriorityTypeList> {
  DataGridController dataGridController = DataGridController();
  int selectedIndex = -1;
  double idBoxSize = 90.0;
  List<String> get tableColumns {
    return const [
      AppStrings.id,
      AppStrings.priorityType,
      AppStrings.actions,
    ];
  }

  @override
  Widget build(BuildContext context) {
    //  widget.priorityTypeController.text = "";
    final themeData = Theme.of(context);
    return BlocBuilder<PriorityTypeBloc, PriorityTypeState>(
      builder: (context, state) {
        return DataTable(
            showCheckboxColumn: false,
            showBottomBorder: true,
            border: null,
            columns:  [
              DataColumn(
                  label: Text(
                tableColumns[0],
              )),
              DataColumn(label: Text(tableColumns[1])),
              DataColumn(
                  label: Expanded(
                      child: Text(
                tableColumns[2],
                textAlign: TextAlign.center,
              ))),
            ],
            rows: List.generate(
                state.priorityTypeList.length,
                (index) => DataRow.byIndex(
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
                        state.priorityTypeList[index].name!.length > 30
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: (widget.dataTableWidth -
                                            600 -
                                            idBoxSize) *
                                        0.9,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Tooltip(
                                        message:
                                            "${state.priorityTypeList[index].name}",
                                        preferBelow: false,
                                        height: 30,
                                        textAlign: TextAlign.justify,
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                        child: Text(
                                          "${state.priorityTypeList[index].name}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: null,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(
                                width:
                                    (widget.dataTableWidth - 600 - idBoxSize),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    "${state.priorityTypeList[index].name}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                      ),
                      DataCell(Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                widget.priorityTypeUpdateController.text =
                                    state.priorityTypeList[index].name!;
                                context.read<PriorityTypeBloc>().add(
                                    PriorityTypePageChangeEvent(
                                        page: 2,
                                        priorityType:
                                            state.priorityTypeList[index]));
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.pen,
                                color: Colors.green,
                                size: 15,
                              )),
                          spacery10,
                          IconButton(
                              onPressed: () {
                                context.read<PriorityTypeBloc>().add(
                                    PriorityTypePageChangeEvent(
                                        page: 3,
                                        priorityType:
                                            state.priorityTypeList[index]));
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
                      context.read<PriorityTypeBloc>().add(
                          selectedPriorityTypeEvent(
                              priorityType: state.priorityTypeList[index]));
                      //state.subRegionList[index].isSelected = true;
                    })),
            headingTextStyle: TextStyle(
                color: themeData.textColor,
                //fontFamily: 'Poppins,sans-serif',
                fontWeight: FontWeight.w700));
      },
    );
  }
}
