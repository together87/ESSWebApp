import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/observation_types/bloc/observation_type_event.dart';
import 'package:ecosys_safety/features/administration/masters/observation_types/bloc/observation_type_bloc.dart';
import 'package:ecosys_safety/features/administration/masters/observation_types/bloc/observation_type_state.dart';
import 'package:ecosys_safety/features/administration/masters/observation_types/data/model/visibility_type.dart';
import 'package:flutter/material.dart';
import 'package:ecosys_safety/constants/app_strings.dart';

class VisibilityTypeSelect extends StatelessWidget {
  const VisibilityTypeSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObservationTypeBloc, ObservationTypeState>(
        builder: (context, state) {
      Map<String, VisibilityType> items = {}
        ..addEntries(state.visibilityTypeList.map(
            (visibilityType) => MapEntry(visibilityType.name ?? '', visibilityType)));
      return CustomSingleSelect(
          items: items,
          hint: 'Select ${AppStrings.visibility}',
          width: (MediaQuery.of(context).size.width - 500) * 0.5,
          height: 52,
          selectedValue: state.selectedVisibilityType == null
              ? ''
              : state.selectedVisibilityType?.name == "null" ? '': state.selectedVisibilityType?.name,
          onChanged: (visibilityType) {
            context
                .read<ObservationTypeBloc>()
                .add(VisibilityTypeSelectedEvent(visibilityType: visibilityType.value));
          });
    });
  }
}
