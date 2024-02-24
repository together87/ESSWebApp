import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/bloc/regions_timezone_bloc.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/bloc/regions_timezone_state.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/time_zone.dart';
import 'package:flutter/material.dart';
import '../bloc/regions_timezone_event.dart';

class TimeZoneCreateSelect extends StatelessWidget {
  const TimeZoneCreateSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegionsTimezoneBloc, RegionsTimezoneState>(
        builder: (context, state) {
      Map<String, TimeZone> items = {}..addEntries(state.timezoneCreateList
          .map((timezone) => MapEntry(timezone.name ?? '', timezone)));
      return CustomSingleSelect(
          items: items,
          selectedValue: state.selectedTimezoneCreate == null
              ? ''
              : state.selectedTimezoneCreate?.name,
          onChanged: (timezone) {
            context.read<RegionsTimezoneBloc>().add(
                CreateTimezoneChangedEvent(timezone: timezone.value));
          });
    });
  }
}
