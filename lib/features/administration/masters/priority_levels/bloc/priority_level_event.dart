import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/data/model/priorityType.dart';

import '../data/model/priority_level_response.dart';

class PriorityLevelEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPriorityLevelByIdEvent extends PriorityLevelEvents {}

class CreateNewPriorityLevelEvent extends PriorityLevelEvents {
  final int page;
  PriorityLevel priorityLevel;

  CreateNewPriorityLevelEvent(
      {required this.page, required this.priorityLevel});
}

class PageChangeEvent extends PriorityLevelEvents {
  final int page;
  PriorityLevel? priorityLevel;

  PageChangeEvent({required this.page, this.priorityLevel});
}

class UpdatePriorityLevelEvent extends PriorityLevelEvents {
  final int page;
  PriorityLevel priorityLevel;
  PriorityType priorityType;

  UpdatePriorityLevelEvent(
      {required this.page,
      required this.priorityLevel,
      required this.priorityType});
}

class PriorityLevelSelectedEvent extends PriorityLevelEvents {
  PriorityLevel priorityLevel;

  PriorityLevelSelectedEvent({required this.priorityLevel});
}

class DeletePriorityLevelEvent extends PriorityLevelEvents {
  final int page;
  int id;

  DeletePriorityLevelEvent({required this.page, required this.id});
}

class PriorityLevelLoadingEvent extends PriorityLevelEvents {}

class getPriorityTypeByIdEvent extends PriorityLevelEvents {
  int? id;

  getPriorityTypeByIdEvent({required this.id});
}

class CreatePriorityLevelEvent extends PriorityLevelEvents {
  final int page;

  CreatePriorityLevelEvent({required this.page});
}

class SelectPriorityTypeEvent extends PriorityLevelEvents {
  final PriorityType priorityType;

  SelectPriorityTypeEvent({required this.priorityType});
}
