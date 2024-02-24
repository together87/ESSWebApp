import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/data/model/priorityType.dart';
import '../data/model/priority_level_response.dart';

class PriorityLevelState extends Equatable {
  final List<PriorityLevel> priorityLevelList;
  final List<PriorityType> priorityTypeList;
  final EntityStatus? crudStatus;
  final PriorityLevel? selectedPriorityLevel;
  final PriorityType? selectedPriorityType;
  final int? page;
  final String message;
  final bool statechange;
  const PriorityLevelState(
      {this.priorityLevelList = const [],
      this.priorityTypeList = const [],
      this.crudStatus = EntityStatus.initial,
      this.selectedPriorityLevel,
      this.selectedPriorityType,
      this.page = 0,
      this.statechange = true,
      this.message = ''});

  @override
  List<Object?> get props => [
        priorityLevelList,
        priorityTypeList,
        crudStatus,
        selectedPriorityLevel,
        selectedPriorityType,
        page,
        statechange,
        message
      ];

  PriorityLevelState copyWith(
      {List<PriorityLevel>? priorityLevelList,
      List<PriorityType>? priorityTypeList,
      EntityStatus? crudStatus,
      PriorityLevel? selectedPriorityLevel,
      PriorityType? selectedPriorityType,
      int? page,
      bool? statechange,
      String? message}) {
    return PriorityLevelState(
        priorityLevelList: priorityLevelList ?? this.priorityLevelList,
        priorityTypeList: priorityTypeList ?? this.priorityTypeList,
        crudStatus: crudStatus ?? this.crudStatus,
        selectedPriorityLevel:
            selectedPriorityLevel??this.selectedPriorityLevel ,
        selectedPriorityType: selectedPriorityType/*??this.selectedPriorityType*/,
        page: page ?? this.page,
        statechange: statechange ?? this.statechange,
        message: message ?? '');
  }
}
