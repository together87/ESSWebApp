import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/severity_level/bloc/severity_level_event.dart';
import 'package:ecosys_safety/features/administration/masters/severity_level/data/model/severityLevel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:ecosys_safety/features/theme/app_theme.dart';
import '../bloc/severity_level_bloc.dart';
import '../bloc/severity_level_state.dart';
import 'package:ecosys_safety/constants/app_strings.dart';
class SeverityLevelList extends StatefulWidget {
  double dataTableWidth;
  SeverityLevelList(
      {super.key,
      required this.severitylevelController,
      required this.severitylevelUpdateController,
      required this.dataTableWidth});

  final TextEditingController severitylevelUpdateController;
  final TextEditingController severitylevelController;

  @override
  State<StatefulWidget> createState() => _SeverityLevelListState();
}

class _SeverityLevelListState extends State<SeverityLevelList> {
  DataGridController dataGridController = DataGridController();
  int selectedIndex = -1;
  double idBoxSize = 80.0;

  @override
  Widget build(BuildContext context) {
    //  widget.severitylevelController.text = "";
    final themeData = Theme.of(context);
    return BlocBuilder<SeveritylevelBloc, SeveritylevelState>(
      builder: (context, state) {
        return DataTable(
            showCheckboxColumn: false,
            dividerThickness: 0,
            columns: const [
              DataColumn(
                  label: Text(
                AppStrings.id,
              )),
              DataColumn(label: Text(AppStrings.severityLevel)),
              DataColumn(
                  label: Expanded(
                      child: Text(
                AppStrings.actions,
                textAlign: TextAlign.center,
              ))),
            ],
            rows: List.generate(
                state.severityLevelList.length,
                (index) => DataRow.byIndex(
                    color: MaterialStateColor.resolveWith((states) {
                      return index == selectedIndex
                          ? bluePageHeader
                          : Colors.white; //make tha magic!
                    }),
                    index: index,
                    cells: [
                      DataCell(SizedBox(
                          width: idBoxSize, child: Text("${index + 1}"))),
                      DataCell(
                        state.severityLevelList[index].level!.length > 30
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: (widget.dataTableWidth -
                                            560 -
                                            idBoxSize) *
                                        1,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Tooltip(
                                        message:
                                            "${state.severityLevelList[index].level}",
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
                                          "${state.severityLevelList[index].level}",
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
                                    (widget.dataTableWidth - 560 - idBoxSize),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    "${state.severityLevelList[index].level}",
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
                                widget.severitylevelUpdateController.text =
                                    state.severityLevelList[index].level!;
                                context.read<SeveritylevelBloc>().add(
                                    SeveritylevelPageChangeEvent(
                                        page: 2,
                                        severitylevel:
                                            state.severityLevelList[index]));
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.pen,
                                color: Colors.green,
                                size: 15,
                              )),
                          spacery10,
                          IconButton(
                              onPressed: () {
                                context.read<SeveritylevelBloc>().add(
                                    SeveritylevelPageChangeEvent(
                                        page: 3,
                                        severitylevel:
                                            state.severityLevelList[index]));
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
                      context.read<SeveritylevelBloc>().add(
                          selectedSeverityLevelEvent(
                              severitylevel: state.severityLevelList[index]));
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
