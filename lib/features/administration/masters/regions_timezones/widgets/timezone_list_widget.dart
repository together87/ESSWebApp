import 'package:ecosys_safety/features/administration/masters/regions_timezones/bloc/regions_timezone_event.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/time_zone.dart';
import 'package:ecosys_safety/features/theme/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import '../../../../../common_libraries.dart';
import '../../../../../constants/app_strings.dart';
import '../../../../../constants/color.dart';
import '../../../../../constants/style.dart';
import '../bloc/regions_timezone_bloc.dart';
import '../bloc/regions_timezone_state.dart';

class TimezoneListWidget extends StatefulWidget {
  double dataTableWidth;

  TimezoneListWidget({super.key, required this.dataTableWidth});

  @override
  State<StatefulWidget> createState() => _TimezoneListWidgetState();
}

class _TimezoneListWidgetState extends State<TimezoneListWidget> {
  List<String> get tableColumns {
    return const [
      AppStrings.id,
      AppStrings.timezones,
      AppStrings.action,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegionsTimezoneBloc, RegionsTimezoneState>(
      builder: (context, state) {
        return TableView(
          columns: tableColumns,
          rows: state.timezoneList
              .map((timezone) => [
                    CustomDataCell(
                      data: timezone.id!,
                    ),
                    CustomDataCell(
                      data: timezone.timeZoneName!,
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              context.read<RegionsTimezoneBloc>().add(
                                  TimezonePageChangedEvent(
                                      page: 2, timeZone: timezone));
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.pen,
                              color: Colors.green,
                              size: 15,
                            )),
                        spacery10,
                        IconButton(
                            onPressed: () {
                              context.read<RegionsTimezoneBloc>().add(
                                  TimezonePageChangedEvent(
                                      page: 3, timeZone: timezone));
                            },
                            icon: const FaIcon(FontAwesomeIcons.trashCan,
                                color: Colors.red, size: 15)),
                      ],
                    ),
                  ])
              .toList(),
        );
      },
    );
  }
}

class TimezoneDataListWidget extends StatefulWidget {
  final List<TimeZone> timezones;
  double dataTableWidth;

  TimezoneDataListWidget(
      {super.key, required this.timezones, required this.dataTableWidth});

  @override
  State<StatefulWidget> createState() => _TimezoneDataListWidgetState();
}

class _TimezoneDataListWidgetState extends State<TimezoneDataListWidget> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<RegionsTimezoneBloc, RegionsTimezoneState>(
      builder: (context, state) {
        return DataTable(
            showCheckboxColumn: false,
            dividerThickness: 0,
            columns: const [
              DataColumn(
                  label: Text(
                AppStrings.id,
              )),
              DataColumn(label: Text(AppStrings.timezones)),
              DataColumn(
                  label: Text(
                AppStrings.action,
                textAlign: TextAlign.center,
              )),
            ],
            rows: List.generate(
                state.timezoneList.length,
                (index) => DataRow.byIndex(
                      index: index,
                      cells: [
                        DataCell(SizedBox(
                            width: (widget.dataTableWidth - 650) / 2 * 0.2,
                            child: Text("${index + 1}"))),
                        DataCell(
                            state.timezoneList[index].timeZoneName!.length > 30
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: (widget.dataTableWidth - 650) /
                                            2 *
                                            0.7 *
                                            0.7,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Tooltip(
                                            message:
                                                "${state.timezoneList[index].timeZoneName}",
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
                                              "${state.timezoneList[index].timeZoneName}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: null,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: (widget.dataTableWidth - 650) /
                                            2 *
                                            0.3 *
                                            0.7,
                                      )
                                    ],
                                  )
                                : SizedBox(
                                    width:
                                        (widget.dataTableWidth - 690) / 2 * 0.7,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        "${state.timezoneList[index].timeZoneName}",
                                        maxLines: null,
                                      ),
                                    ),
                                  )),
                        DataCell(Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  context.read<RegionsTimezoneBloc>().add(
                                      TimezonePageChangedEvent(
                                          page: 3,
                                          timeZone: state.timezoneList[index]));

                                  /*context.read<RegionsTimezoneBloc>().add(
                                      DeleteTimezoneEvent(
                                          id: state.timezoneList[index].id!));*/
                                },
                                icon: const FaIcon(FontAwesomeIcons.trashCan,
                                    color: Colors.red, size: 12))
                          ],
                        )),
                      ],
                    )),
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
