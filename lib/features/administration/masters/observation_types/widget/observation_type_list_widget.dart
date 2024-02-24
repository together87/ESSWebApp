import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/observation_types/bloc/observation_type_event.dart';
import 'package:ecosys_safety/features/administration/masters/observation_types/bloc/observation_type_state.dart';
import 'package:ecosys_safety/features/administration/masters/observation_types/bloc/observation_type_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:ecosys_safety/features/theme/app_theme.dart';
import 'package:ecosys_safety/constants/app_strings.dart';
class ObservationTypeListWidget extends StatefulWidget {
  double dataTableWidth;
  ObservationTypeListWidget({
    super.key,
    required this.observationTypeController,
    required this.observationTypeUpdateController,
    required this.dataTableWidth,

  });
  final TextEditingController observationTypeUpdateController;
  final TextEditingController observationTypeController;

  @override
  State<StatefulWidget> createState() => _ObservationTypeListWidgetState();
}

class _ObservationTypeListWidgetState extends State<ObservationTypeListWidget> {
  DataGridController dataGridController = DataGridController();
  int selectedIndex = -1;
  double idBoxSize = 80.0;
  List<String> get tableColumns {
    return const [
      AppStrings.id,
      AppStrings.observationType,
      AppStrings.severityLevel,
      AppStrings.visibility,
      AppStrings.actions,
    ];
  }

  @override
  Widget build(BuildContext context) {
    //  widget.priorityTypeController.text = "";
    final themeData = Theme.of(context);
    return BlocBuilder<ObservationTypeBloc, ObservationTypeState>(
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
               DataColumn(label: Text(tableColumns[3])),
              DataColumn(
                  label: Expanded(
                      child: Text(
                tableColumns[4],
                textAlign: TextAlign.center,
              ))),
            ],
            rows: List.generate(
                state.observationTypeList.length,
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
                        state.observationTypeList[index].name!.length > 30
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: (widget.dataTableWidth -
                                            650 -
                                            idBoxSize) *
                                        0.9 *
                                        0.3,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Tooltip(
                                        message:
                                            "${state.observationTypeList[index].name}",
                                        preferBelow: false,
                                        height: 30,
                                        textAlign: TextAlign.justify,
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                        child: Text(
                                          "${state.observationTypeList[index].name}",
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
                                    (widget.dataTableWidth - 650 - idBoxSize) *
                                        0.3,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                      "${state.observationTypeList[index].name}"),
                                ),
                              ),
                      ),
                      DataCell(state.observationTypeList[index].severityLevel !=
                              null
                          ? (state.observationTypeList[index].severityLevel!
                                      .length >
                                  30
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: (widget.dataTableWidth -
                                              700 -
                                              idBoxSize) *
                                          0.9 *
                                          0.4,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Tooltip(
                                          message:
                                              "${state.observationTypeList[index].severityLevel}",
                                          preferBelow: false,
                                          height: 30,
                                          textAlign: TextAlign.justify,
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                          child: Text(
                                            "${state.observationTypeList[index].severityLevel}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: null,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: (widget.dataTableWidth -
                                              700 -
                                              idBoxSize) *
                                          0.1 *
                                          0.4,
                                    )
                                  ],
                                )
                              : SizedBox(
                                  width: (widget.dataTableWidth -
                                          700 -
                                          idBoxSize) *
                                      0.4,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                        "${state.observationTypeList[index].severityLevel}"),
                                  ),
                                ))
                          : SizedBox(
                              width: (widget.dataTableWidth - 700 - idBoxSize) *
                                  0.4,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(""),
                              ),
                            )),
                      DataCell(state.observationTypeList[index].visibilityType !=
                              null
                          ? (state.observationTypeList[index].visibilityType!
                                      .length >
                                  30
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: (widget.dataTableWidth -
                                              650 -
                                              idBoxSize) *
                                          0.9 *
                                          0.3,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Tooltip(
                                          message:
                                              "${state.observationTypeList[index].visibilityType}",
                                          preferBelow: false,
                                          height: 30,
                                          textAlign: TextAlign.justify,
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                          child: Text(
                                            "${state.observationTypeList[index].visibilityType}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: null,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: (widget.dataTableWidth -
                                              650 -
                                              idBoxSize) *
                                          0.1 *
                                          0.3,
                                    )
                                  ],
                                )
                              : SizedBox(
                                  width: (widget.dataTableWidth -
                                          650 -
                                          idBoxSize) *
                                      0.3,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                        "${state.observationTypeList[index].visibilityType}"),
                                  ),
                                ))
                          : SizedBox(
                              width: (widget.dataTableWidth - 700 - idBoxSize) *
                                  0.3,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(""),
                              ),
                            )),
                      
                      DataCell(Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                widget.observationTypeUpdateController.text =
                                    state.observationTypeList[index].name!;
                                context.read<ObservationTypeBloc>().add(
                                    PageChangeEvent(
                                        page: 2,
                                        observationType:
                                            state.observationTypeList[index]));
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.pen,
                                color: Colors.green,
                                size: 15,
                              )),
                          spacery10,
                          IconButton(
                              onPressed: () {
                                context.read<ObservationTypeBloc>().add(
                                    PageChangeEvent(
                                        page: 3,
                                        observationType:
                                            state.observationTypeList[index]));
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
                      context.read<ObservationTypeBloc>().add(
                          ObservationTypeSelectedEvent(
                              observationType: state.observationTypeList[index]));
                      //state.subRegionList[index].isSelected = true;
                    })),
            showBottomBorder: true,
            border: null,
            headingTextStyle: TextStyle(
                color: themeData.textColor,
                //fontFamily: 'Poppins,sans-serif',
                fontWeight: FontWeight.w700));
      },
    );
  }
}
