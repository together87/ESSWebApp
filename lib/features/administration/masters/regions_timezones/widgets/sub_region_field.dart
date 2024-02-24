import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/bloc/regions_timezone_bloc.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/bloc/regions_timezone_state.dart';
import 'package:flutter/material.dart';

import '../bloc/regions_timezone_event.dart';
import '/common_libraries.dart';

class SubRegionField extends StatelessWidget {
  const SubRegionField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegionsTimezoneBloc, RegionsTimezoneState>(
      builder: (context, state) {
        return CustomTextField(
          //key: ValueKey(state.loadedAudit?.id),
          // initialValue: state.auditName,
          validator: (value) {
            if (Validation.isNotCheckedMin(value)) {
              return 'Region name is required';
            }
            return null;
          },
          hintText: 'Sub region name (min 3 max 100 characters)',
          onChanged: (subRegion) {
            context
                .read<RegionsTimezoneBloc>()
                .add(SubRegionTextChanged(subRegion: subRegion));
          },
        );
      },
    );
  }
}
