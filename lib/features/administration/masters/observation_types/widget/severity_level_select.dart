import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/observation_types/bloc/observation_type_event.dart';
import 'package:ecosys_safety/features/administration/masters/observation_types/bloc/observation_type_bloc.dart';
import 'package:ecosys_safety/features/administration/masters/observation_types/bloc/observation_type_state.dart';
import 'package:ecosys_safety/features/administration/masters/severity_level/data/model/severityLevel.dart';
import 'package:ecosys_safety/constants/app_strings.dart';

class SeverityLevelSelect extends StatelessWidget {
  const SeverityLevelSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObservationTypeBloc, ObservationTypeState>(
        builder: (context, state) {
      Map<String, SeverityLevel> items = {}
        ..addEntries(state.severityLevelList.map(
            (severityLevel) => MapEntry(severityLevel.level ?? '', severityLevel)));
      return CustomSingleSelect(
          items: items,
          hint: 'Select ${AppStrings.severityLevel}',
          width: (MediaQuery.of(context).size.width - 500) * 0.5,
          height: 52,
          selectedValue: state.selectedSeverityLevel == null
              ? ''
              : state.selectedSeverityLevel?.level == "null" ? '': state.selectedSeverityLevel?.level,
          onChanged: (severityLevel) {
            context
                .read<ObservationTypeBloc>()
                .add(SeverityLevelSelectedEvent(severityLevel: severityLevel.value));
          });
    });
  }
}
