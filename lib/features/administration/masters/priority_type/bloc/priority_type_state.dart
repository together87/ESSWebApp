import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/data/model/priorityType.dart';

class PriorityTypeState extends Equatable {
  final List<PriorityType> priorityTypeList;
  final EntityStatus? priorityTypeCrud;
  final PriorityType? selectedPriorityType;
  final int? priorityTypePage;
  final String message;
  const PriorityTypeState({
    this.priorityTypeList = const [],
    this.priorityTypeCrud = EntityStatus.initial,
    this.priorityTypePage = 0,
    this.message = "",
    this.selectedPriorityType,
  });

  @override
  List<Object?> get props => [
        priorityTypeList,
        priorityTypeCrud,
        priorityTypePage,
        message,
        selectedPriorityType,
      ];
  PriorityTypeState copyWith({
    List<PriorityType>? priorityTypeList,
    EntityStatus? priorityTypeCrud,
    int? priorityTypePage,
    String? message,
    PriorityType? selectedPriorityType,
  }) {
    return PriorityTypeState(
      priorityTypeList: priorityTypeList ?? this.priorityTypeList,
      priorityTypeCrud: priorityTypeCrud ?? this.priorityTypeCrud,
      priorityTypePage: priorityTypePage ?? this.priorityTypePage,
      selectedPriorityType:
          selectedPriorityType ,
      message: message ?? '',
    );
  }
}
