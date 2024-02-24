import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/data/model/priorityType.dart';

class PriorityTypeEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLoadPriorityTypeByIdEvent extends PriorityTypeEvents {}

class PriorityTypeCreateNewEvent extends PriorityTypeEvents {
  final int page;
  PriorityType priorityType;
  PriorityTypeCreateNewEvent(
      {required this.page, required this.priorityType});
}

class PriorityTypePageChangeEvent extends PriorityTypeEvents {
  final int page;
  PriorityType? priorityType;
  PriorityTypePageChangeEvent({required this.page,  this.priorityType});
}

class PriorityTypeUpdateEvent extends PriorityTypeEvents {
  final int page;
  PriorityType priorityType;
  PriorityTypeUpdateEvent({required this.page, required this.priorityType});
}

class selectedPriorityTypeEvent extends PriorityTypeEvents {
  final PriorityType priorityType;
  selectedPriorityTypeEvent({required this.priorityType});
}
class PriorityTypeDeleteEvent extends PriorityTypeEvents {
  final int page;
  int id;
  PriorityTypeDeleteEvent({required this.page, required this.id});
}

class PriorityTypeLoadingEvent extends PriorityTypeEvents {
  PriorityTypeLoadingEvent();
}
