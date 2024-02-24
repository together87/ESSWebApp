import 'package:ecosys_safety/features/administration/masters/regions_timezones/bloc/regions_timezone_event.dart';
import 'package:ecosys_safety/features/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../../common_libraries.dart';
import '../../../../../constants/app_strings.dart';
import '../../../../../constants/color.dart';
import '../../../../../constants/style.dart';
import '../bloc/regions_timezone_bloc.dart';
import '../bloc/regions_timezone_state.dart';
import '../data/model/sub_region.dart';

class RegionListWidget extends StatefulWidget {
  double dataTableWidth;

  RegionListWidget(
      {super.key,
      required this.subRegionController,
      required this.subRegionCreateController,
      required this.dataTableWidth});

  final TextEditingController subRegionController;
  final TextEditingController subRegionCreateController;

  @override
  State<StatefulWidget> createState() => _RegionListWidgetState();
}

class _RegionListWidgetState extends State<RegionListWidget> {
  DataGridController dataGridController = DataGridController();

  int selectedIndex = 0;

  List<String> get tableColumns {
    return const [
      AppStrings.id,
      AppStrings.subRegion,
      AppStrings.timezones,
      AppStrings.actions,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    widget.subRegionCreateController.text = "";
    return BlocBuilder<RegionsTimezoneBloc, RegionsTimezoneState>(
      builder: (context, state) {
        return DataTable(
            showCheckboxColumn: false,
            dividerThickness: 0,
            columns: [
              DataColumn(
                  label: Text(
                tableColumns.first,
              )),
              DataColumn(label: Text(tableColumns[1])),
              DataColumn(
                  label: Expanded(
                      child: Text(
                tableColumns[2],
                textAlign: TextAlign.left,
              ))),
              DataColumn(
                  label: Expanded(
                      child: Text(
                tableColumns[3],
                textAlign: TextAlign.center,
              ))),
            ],
            rows: List.generate(
                state.subRegionList.length,
                (index) => DataRow.byIndex(
                    color: MaterialStateColor.resolveWith((states) {
                      return index == selectedIndex
                          ? bluePageHeader
                          : Colors.white; //make tha magic!
                    }),
                    index: index,
                    cells: [
                      DataCell(Text("${index + 1}")),
                      DataCell(state.subRegionList[index].name!.length > 30
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: ((widget.dataTableWidth - 400) / 2 -
                                          420) *
                                      0.9,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Tooltip(
                                      message:
                                          "${state.subRegionList[index].name}",
                                      preferBelow: false,
                                      height: 30,
                                      textAlign: TextAlign.justify,
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      child: Text(
                                        "${state.subRegionList[index].name}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: null,
                                      ),
                                    ),
                                  ),
                                ),
                                
                              ],
                            )
                          : SizedBox(
                              width: ((widget.dataTableWidth - 400) / 2 - 425),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  "${state.subRegionList[index].name}",
                                  maxLines: null,
                                ),
                              ),
                            )),
                      const DataCell(Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("View"),
                          ),
                          SizedBox(
                            width: 75,
                          )
                        ],
                      )),
                      DataCell(Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                widget.subRegionController.text =
                                    state.subRegionList[index].name!;

                                context.read<RegionsTimezoneBloc>().add(
                                    RegionPageChangedEvent(
                                        page: 2,
                                        subRegion: state.subRegionList[index]));
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.pen,
                                color: Colors.green,
                                size: 12,
                              )),
                          spacery10,
                          IconButton(
                              onPressed: () {
                                context
                                    .read<RegionsTimezoneBloc>()
                                    .add(RegionPageChangedEvent(
                                      page: 3,
                                      subRegion: state.subRegionList[index],
                                    ));
                              },
                              icon: const FaIcon(FontAwesomeIcons.trashCan,
                                  color: Colors.red, size: 12))
                        ],
                      )),
                    ],
                    selected: selectedIndex == index,
                    onSelectChanged: (isSelected) {
                      setState(() {
                        selectedIndex = index;
                      });
                      context.read<RegionsTimezoneBloc>().add(
                          LoadAssociatedTimezoneEvent(
                              subRegion: state.subRegionList[index]));
                      //state.subRegionList[index].isSelected = true;
                    })),
            showBottomBorder: true,
            border: null,
            headingTextStyle: TextStyle(
                color: themeData.textColor,
                //fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700));
      },
    );
  }
}
