import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/priority_levels/bloc/priority_level_event.dart';
import 'package:ecosys_safety/features/administration/masters/priority_levels/bloc/priority_level_bloc.dart';
import 'package:ecosys_safety/features/administration/masters/priority_levels/bloc/priority_level_state.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/data/model/priorityType.dart';
import 'package:flutter/material.dart';
import 'package:ecosys_safety/constants/app_strings.dart';
class PriorityTypeSelect extends StatelessWidget {
  const PriorityTypeSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriorityLevelBloc, PriorityLevelState>(
        builder: (context, state) {
      Map<String, PriorityType> items = {}
        ..addEntries(state.priorityTypeList.map(
            (priorityType) => MapEntry(priorityType.name ?? '', priorityType)));
      return CustomSingleSelect(
          items: items,
          hint: 'Select ${AppStrings.priorityType}',
          width: (MediaQuery.of(context).size.width - 500) * 0.5,
          height: 52,
          selectedValue: state.selectedPriorityType == null
              ? ''
              : state.selectedPriorityType?.name == "null" ? '': state.selectedPriorityType?.name,
          onChanged: (priorityType) {
            context
                .read<PriorityLevelBloc>()
                .add(SelectPriorityTypeEvent(priorityType: priorityType.value));
          });
    });
  }
}
