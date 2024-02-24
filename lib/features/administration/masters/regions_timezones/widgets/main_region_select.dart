import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/bloc/regions_timezone_bloc.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/bloc/regions_timezone_state.dart';
import 'package:flutter/material.dart';

import '../bloc/regions_timezone_event.dart';
import '../data/model/region.dart';

class MainRegionSelect extends StatelessWidget {
  const MainRegionSelect({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegionsTimezoneBloc, RegionsTimezoneState>(
        builder: (context, state) {
      Map<String, Region> items = {}..addEntries(state.regionList
          .map((region) => MapEntry(region.name ?? '', region)));
      return CustomSingleSelect(
          items: items,
          selectedValue: state.selectedRegion?.name,
          onChanged: (region) {
            context
                .read<RegionsTimezoneBloc>()
                .add(RegionChangedEvent(region: region.value));
          });
    });
  }
}
