import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/bloc/regions_timezone_bloc.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/bloc/regions_timezone_state.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/sub_region.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/time_zone.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/time_zone_create.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/widgets/timezone_list_widget.dart';

import '../bloc/regions_timezone_event.dart';
import '../widgets/main_region_select.dart';
import '../widgets/region_list_widget.dart';
import '../widgets/timezone_create_select.dart';

class RegionsListView extends StatefulWidget {
  const RegionsListView({super.key});

  @override
  State<RegionsListView> createState() => _RegionsState();
}

class _RegionsState extends State<RegionsListView> {
  _RegionsState();

  TextEditingController subRegionController = TextEditingController();
  TextEditingController subRegionCreateController = TextEditingController();
  TextEditingController timezoneController = TextEditingController();
  final ScrollController _horizontal = ScrollController(), _vertical = ScrollController();
  final ScrollController _timezone_horizontal = ScrollController(), _timezone_vertical = ScrollController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<RegionsTimezoneBloc>().add(LoadMainRegionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegionsTimezoneBloc, RegionsTimezoneState>(
      builder: (context, state) {
        return Stack(
          children: [
            Container(
                color: bluePageHeader,
                width: double.infinity,
                height: 160,
                padding: inset16,
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(36))),
                      width: 72,
                      height: 72,
                      child: const Icon(
                        Icons.menu,
                        size: 60,
                        color: Colors.blueAccent,
                      ),
                    ),
                    spacerx24,
                    Text("Regions/ Time zones", style: textSemiBold20.copyWith(color: AppColors.pageMainTitleTextColor)),
                  ],
                )),
            Positioned(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 100, 12, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          child: Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                    child: Card(
                      margin: inset12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: _buildRegion(),
                      ),
                    ),
                  ))),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                    child: Card(
                      margin: inset12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: _buildTimezone(),
                      ),
                    ),
                  )))
                ],
              ),
            ))
          ],
        );
      },
      listener: (context, state) {
        // Showing notification in case of success and failure
        if (state.message.isNotEmpty) {
          if (state.regionCrudStatus == EntityStatus.success || state.timezoneCrudStatus == EntityStatus.success) {
            _showNotification(message: state.message, notifyType: NotifyType.success);
          } else if (state.regionCrudStatus == EntityStatus.failure || state.timezoneCrudStatus == EntityStatus.failure) {
            _showNotification(message: state.message, notifyType: NotifyType.error);
          }
        }
      },
    );
  }

  _showNotification({required String message, required NotifyType notifyType}) {
    CustomNotification(
      context: context,
      notifyType: notifyType,
      content: message,
    ).showNotification();
  }

  _buildRegionTitleBar() {
    return Padding(
      padding: inset16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppStrings.subTitleRegions, style: subMenuTitle),
        ],
      ),
    );
  }

  _buildSubRegionTitleBar(RegionsTimezoneState state) {
    return Padding(
      padding: inset10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppStrings.subTitleSubRegions, style: subMenuTitle),
          CustomButton(
            backgroundColor: Colors.blue,
            borderRadius: 80,
            padding: const EdgeInsets.symmetric(horizontal: 7.8, vertical: 4.2),
            onClick: () {
              if (state.selectedRegion == null) {
                return;
              }
              context.read<RegionsTimezoneBloc>().add(RegionPageChangedEvent(page: 1));
            },
            text: AppStrings.createNew,
          )
        ],
      ),
    );
  }

  _getSelectedSubRegionNameOrEmptyString() {
    var state = context.read<RegionsTimezoneBloc>().state;
    if (state.selectedSubRegion == null || state.subRegionList.isEmpty) {
      return '';
    }

    return "for ${state.selectedSubRegion?.name}";
  }

  _buildTimezoneTitleBar() {
    return Padding(
      padding: inset16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Text(
            overflow: TextOverflow.ellipsis,
            "${AppStrings.timezones} ${_getSelectedSubRegionNameOrEmptyString()}",
            style: subMenuTitle,
          )),
          CustomButton(
            backgroundColor: Colors.blue,
            borderRadius: 80,
            disabled: _isDisabled(),
            padding: const EdgeInsets.symmetric(horizontal: 7.8, vertical: 4.2),
            onClick: () {
              context.read<RegionsTimezoneBloc>().add(LoadCreateTimezonesEvent(page: 1));
            },
            text: AppStrings.createNew,
          )
        ],
      ),
    );
  }

  _buildRegionDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.mainRegion,
          style: textNormal14,
          textAlign: TextAlign.left,
        ),
        spacery12,
        const MainRegionSelect(),
      ],
    );
  }

  _buildRegion() {
    final state = context.read<RegionsTimezoneBloc>().state;
    return state.regionPage == 0
        ? _buildRegionList()
        : state.regionPage == 1
            ? _buildCreatePage(true, state)
            : state.regionPage == 2
                ? _buildUpdatePage(true)
                : _buildDeletePage(true);
  }

  _buildTimezone() {
    final state = context.read<RegionsTimezoneBloc>().state;
    return state.timezonePage == 0
        ? _buildTimezoneList()
        : state.timezonePage == 1
            ? _buildCreatePage(false, state)
            : state.timezonePage == 2
                ? _buildUpdatePage(false)
                : _buildDeletePage(false);
  }

  _buildRegionList() {
    final state = context.read<RegionsTimezoneBloc>().state;
    return <Widget>[
      _buildRegionTitleBar(),
      CustomBottomBorderContainer(),
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          children: [
            _buildRegionDropdown(),
            spacery15,
            CustomBottomBorderContainer(),
            _buildSubRegionTitleBar(state),
            CustomBottomBorderContainer(),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: _buildSubRegionList(state),
      ),
    ];
  }

  _buildSubRegionList(RegionsTimezoneState state) {
    if (state.regionCrudStatus == EntityStatus.loading) {
      return const Loader();
    } else if (state.subRegionList.isNotEmpty) {
      return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        final double dataTableWidth = MediaQuery.of(context).size.width;
        return Scrollbar(
          controller: _vertical,
          thumbVisibility: true,
          trackVisibility: true,
          child: SingleChildScrollView(
              controller: _vertical,
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: double.infinity,
                child: RegionListWidget(
                  subRegionController: subRegionController,
                  subRegionCreateController: subRegionCreateController,
                  dataTableWidth: dataTableWidth,
                ),
              )),
        );
      });
    } else {
      return _buildEmptySubRegionWidget();
    }
  }

  _buildEmptySubRegionWidget() {
    return CustomEmptyPageWidget(
      message: AppStrings.emptyListMessage.replaceFirst('@listName', AppStrings.subRegion).replaceFirst('@listNamePlural', AppStrings.subRegions),
    );
  }

  _buildTimezoneList() {
    final state = context.read<RegionsTimezoneBloc>().state;
    return <Widget>[
      _buildTimezoneTitleBar(),
      CustomBottomBorderContainer(),
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: Column(
          children: [
            _buildTimezoneChildList(state),
          ],
        ),
      ),
    ];
  }

  _buildTimezoneChildList(RegionsTimezoneState state) {
    if (state.timezoneCrudStatus == EntityStatus.loading) {
      return const Loader();
    } else if (state.timezoneList.isNotEmpty) {
      return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        final double dataTableWidth = MediaQuery.of(context).size.width;
        return Scrollbar(
          controller: _timezone_vertical,
          thumbVisibility: true,
          trackVisibility: true,
          child: SingleChildScrollView(
              controller: _timezone_vertical,
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: double.infinity,
                child: TimezoneDataListWidget(
                  timezones: state.timezoneList,
                  dataTableWidth: dataTableWidth,
                ),
              )),
        );
      });
    } else {
      return _buildEmptyTimezoneWidget();
    }
  }

  _buildEmptyTimezoneWidget() {
    return CustomEmptyPageWidget(message: AppStrings.emptyListMessage.replaceFirst('@listName', AppStrings.timezone).replaceFirst('@listNamePlural', AppStrings.timezones));
  }

  _buildCreatePage(bool isRegion, RegionsTimezoneState state) {
    return <Widget>[
      Padding(padding: inset16, child: Text(overflow: TextOverflow.ellipsis, "Create ${isRegion ? "${AppStrings.subRegion} for ${state.selectedRegion?.name}" : "${AppStrings.timezone} ${_getSelectedSubRegionNameOrEmptyString()}"}", style: subMenuTitle)),
      CustomBottomBorderContainer(),
      Padding(
          padding: inset16,
          child: isRegion
              ? Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: subRegionCreateController,
                    initialValue: null,
                    maxLength: 50,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        labelText: '${AppStrings.subregionName}${AppStrings.mandatoryMark}',
                        counterText: '',
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 43, 43, 43),
                        ),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.textgreyColor)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: AppStrings.subregionHint),
                    validator: (value) {
                      if (Validation.isNotCheckedMin(value)) {
                        return AppStrings.minSubregionError;
                      } else if (Validation.isNotCheckedMax(value)) {
                        return AppStrings.maxSubregionError;
                      } else if (Validation.isAlphaNumericWithSpecialChars(value)) {
                        return AppStrings.alphaNumericError.replaceFirst('@fieldName', AppStrings.subregionName);
                      }
                      return null;
                    },
                  ))
              : const TimeZoneCreateSelect()),
      CustomBottomBorderContainer(margin: const EdgeInsets.symmetric(horizontal: 16)),
      Padding(padding: const EdgeInsets.fromLTRB(32, 30, 16, 32), child: Text(AppStrings.actionAppliedWarning, style: textRed)),
      CustomBottomBorderContainer(margin: const EdgeInsets.symmetric(horizontal: 16)),
      Padding(
          padding: inset16,
          child: Row(children: [
            CustomButton(
              backgroundColor: greenBtn,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
              onClick: isRegion
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        final state = context.read<RegionsTimezoneBloc>().state;
                        if (state.selectedRegion != null) {
                          SubRegion subRegion = SubRegion(
                            parentId: state.selectedRegion?.id,
                            parentName: state.selectedRegion?.name,
                            name: subRegionCreateController.text,
                            id: 0,
                          );
                          context.read<RegionsTimezoneBloc>().add(CreateRegionEvent(subRegion: subRegion));
                        }
                      }
                    }
                  : () {
                      final state = context.read<RegionsTimezoneBloc>().state;
                      if (state.selectedRegion != null) {
                        TimeZoneCreate timeZoneCreate = TimeZoneCreate(regionId: state.selectedSubRegion!.id!, timeZoneId: state.selectedTimezoneCreate!.id);
                        context.read<RegionsTimezoneBloc>().add(CreateTimezoneEvent(timeZoneCreate: timeZoneCreate));
                      }
                    },
              text: AppStrings.create,
            ),
            spacerx4,
            CustomButton(
              backgroundColor: AppColors.buttonSecondaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: textNormal14,
              onClick: isRegion
                  ? () {
                      context.read<RegionsTimezoneBloc>().add(RegionPageChangedEvent(page: 0));
                    }
                  : () {
                      context.read<RegionsTimezoneBloc>().add(TimezonePageChangedEvent(page: 0));
                    },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }

  _buildUpdatePage(bool isRegion) {
    final state = context.read<RegionsTimezoneBloc>().state;
    return <Widget>[
      Padding(padding: inset16, child: Text("${AppStrings.update} ${isRegion ? AppStrings.subRegion : AppStrings.timezone}", style: subMenuTitle)),
      CustomBottomBorderContainer(),
      Padding(
          padding: inset16,
          child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                controller: isRegion ? subRegionController : timezoneController,
                maxLength: 50,
                decoration: InputDecoration(
                    counterText: '',
                    border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 43, 43, 43),
                    ),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.textgreyColor)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "${isRegion ? AppStrings.subRegion : AppStrings.timezone} Name(*)",
                    hintText: isRegion ? AppStrings.subregionHint : AppStrings.timezoneHint),
                validator: (value) {
                  if (Validation.isNotCheckedMin(value)) {
                    return AppStrings.minSubregionError;
                  } else if (Validation.isNotCheckedMax(value)) {
                    return AppStrings.maxSubregionError;
                  } else if (Validation.isAlphaNumericWithSpecialChars(value)) {
                    return AppStrings.alphaNumericError.replaceFirst('@fieldName', AppStrings.subRegion);
                  }
                  return null;
                },
                onChanged: (value) {
                  SubRegion subRegion = SubRegion(parentId: state.selectedRegion?.id, parentName: state.selectedRegion?.name, name: value, id: state.selectedSubRegion?.id);
                  context.read<RegionsTimezoneBloc>().add(TextfieldChangedEvent(changedSubregion: subRegion));
                },
              ))),
      CustomBottomBorderContainer(margin: const EdgeInsets.symmetric(horizontal: 16)),
      Padding(padding: const EdgeInsets.fromLTRB(32, 30, 16, 30), child: Text(AppStrings.actionAppliedWarning, style: textRed)),
      CustomBottomBorderContainer(margin: const EdgeInsets.symmetric(horizontal: 16)),
      Padding(
          padding: inset16,
          child: Row(children: [
            CustomButton(
              backgroundColor: AppColors.buttonInfoColor,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
              onClick: isRegion
                  ? () {
                      final state = context.read<RegionsTimezoneBloc>().state;
                      if (_formKey.currentState!.validate()) {
                        if (state.selectedRegion != null) {
                          SubRegion subRegion = SubRegion(parentId: state.selectedRegion?.id, parentName: state.selectedRegion?.name, name: subRegionController.text, id: state.selectedSubRegion?.id);
                          context.read<RegionsTimezoneBloc>().add(UpdateRegionEvent(subRegion: subRegion));
                        }
                      }
                    }
                  : () {
                      final state = context.read<RegionsTimezoneBloc>().state;
                      if (_formKey.currentState!.validate()) {
                        if (state.selectedRegion != null) {
                          TimeZone timeZone = TimeZone(id: state.selectedTimezone?.id, name: timezoneController.text);
                          context.read<RegionsTimezoneBloc>().add(UpdateTimezoneEvent(timeZone: timeZone));
                        }
                      }
                    },
              text: AppStrings.update,
            ),
            spacerx4,
            CustomButton(
              backgroundColor: AppColors.buttonSecondaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: textNormal14,
              onClick: isRegion
                  ? () {
                      context.read<RegionsTimezoneBloc>().add(RegionPageChangedEvent(page: 0));
                    }
                  : () {
                      context.read<RegionsTimezoneBloc>().add(TimezonePageChangedEvent(page: 0));
                    },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }

  _buildDeletePage(bool isRegion) {
    final state = context.read<RegionsTimezoneBloc>().state;
    return <Widget>[
      Padding(padding: inset16, child: Text("Deleting ${isRegion ? AppStrings.subRegion : AppStrings.timezone}", style: subMenuTitle)),
      CustomBottomBorderContainer(),
      Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isRegion ? state.selectedSubRegion!.name! : state.selectedTimezone!.timeZoneName!,
                style: textNormal22,
                overflow: TextOverflow.ellipsis,
              ),
              spacery30,
              Text(AppStrings.actionAppliedWarning, style: textRed),
            ],
          )),
      CustomBottomBorderContainer(margin: const EdgeInsets.symmetric(horizontal: 16)),
      spacery20,
      Padding(
          padding: inset16,
          child: Row(children: [
            CustomButton(
              backgroundColor: warnColor,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
              onClick: isRegion
                  ? () {
                      final state = context.read<RegionsTimezoneBloc>().state;
                      if (state.selectedRegion != null) {
                        context.read<RegionsTimezoneBloc>().add(DeleteRegionEvent(id: state.selectedSubRegion!.id!));
                      }
                      /*    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete SubRegion'),
                            content: const Text(
                                'Do you want to delete the SubRegion really?'),
                            backgroundColor:
                                const Color.fromARGB(255, 248, 169, 169),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  final state =
                                      context.read<RegionsTimezoneBloc>().state;
                                  if (state.selectedRegion != null) {
                                    context.read<RegionsTimezoneBloc>().add(
                                        DeleteRegionEvent(
                                            id: state.selectedSubRegion!.id!));
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );*/
                    }
                  : () {
                      final state = context.read<RegionsTimezoneBloc>().state;
                      if (state.selectedRegion != null) {
                        context.read<RegionsTimezoneBloc>().add(DeleteTimezoneEvent(id: state.selectedTimezone!.id!));
                      }
                      /*    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete Timezone'),
                            content: const Text(
                                'Do you want to delete the Timezone really?'),
                            backgroundColor:
                                const Color.fromARGB(255, 248, 169, 169),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  final state =
                                      context.read<RegionsTimezoneBloc>().state;
                                  if (state.selectedRegion != null) {
                                    context.read<RegionsTimezoneBloc>().add(
                                        DeleteTimezoneEvent(
                                            id: state.selectedTimezone!.id!));
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );*/
                    },
              text: AppStrings.delete,
            ),
            spacerx4,
            CustomButton(
              backgroundColor: AppColors.buttonSecondaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: textNormal14,
              onClick: isRegion
                  ? () {
                      context.read<RegionsTimezoneBloc>().add(RegionPageChangedEvent(page: 0));
                    }
                  : () {
                      context.read<RegionsTimezoneBloc>().add(TimezonePageChangedEvent(page: 0));
                    },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }

  _isDisabled() {
    final state = context.read<RegionsTimezoneBloc>().state;
    return state.subRegionList.isEmpty;
  }
}
