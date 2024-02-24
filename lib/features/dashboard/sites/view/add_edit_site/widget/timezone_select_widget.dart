import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/time_zone.dart';

class TimezoneSelect extends StatelessWidget {
  const TimezoneSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditSiteBloc, AddEditSiteState>(builder: (context, state) {
      Map<String, TimeZone> items = {}..addEntries(state.timezoneList.map((timezone) => MapEntry(timezone.timeZoneName ?? '', timezone)));
      return CustomSingleSelect(
          items: items,
          hint: 'Select ${AppStrings.timezone}',
          width: (MediaQuery.of(context).size.width - 400) * 0.5,
          height: 52,
          isBorderStaus: true,
          selectedValue: state.selectedTimezone == null
              ? ''
              : state.selectedTimezone?.timeZoneName == "null"
                  ? ''
                  : state.selectedTimezone?.timeZoneName,
          onChanged: (timezone) {
            context.read<AddEditSiteBloc>().add(AddEditTimezoneSelectedEvent(timezone: timezone.value));
          });
    });
  }
}
