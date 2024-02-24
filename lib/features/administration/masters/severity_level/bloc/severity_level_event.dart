import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/severity_level/data/model/severityLevel.dart';

class SeveritylevelEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLoadSeverityByIdEvent extends SeveritylevelEvents {}

class SeveritylevelCreateNewEvent extends SeveritylevelEvents {
  final int page;
  SeverityLevel severitylevel;
  SeveritylevelCreateNewEvent(
      {required this.page, required this.severitylevel});
}

class SeveritylevelPageChangeEvent extends SeveritylevelEvents {
  final int page;
  SeverityLevel? severitylevel;
  SeveritylevelPageChangeEvent({required this.page,  this.severitylevel});
}

class SeveritylevelUpdateEvent extends SeveritylevelEvents {
  final int page;
  SeverityLevel severitylevel;
  SeveritylevelUpdateEvent({required this.page, required this.severitylevel});
}

class selectedSeverityLevelEvent extends SeveritylevelEvents {
  SeverityLevel severitylevel;
  selectedSeverityLevelEvent({required this.severitylevel});
}
class SeveritylevelDeleteEvent extends SeveritylevelEvents {
  final int page;
  int id;
  SeveritylevelDeleteEvent({required this.page, required this.id});
}

class SeveritylevelLoadingEvent extends SeveritylevelEvents {
  SeveritylevelLoadingEvent();
}


