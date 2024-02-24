
import '../../../../../common_libraries.dart';
import '../../severity_level/data/model/severityLevel.dart';
import '../data/model/observation_type_response.dart';
import '../data/model/visibility_type.dart';

class ObservationTypeEvents extends Equatable {
  @override
  List<Object?> get props => [];
}


class CreateNewObservationTypeEvent extends ObservationTypeEvents {
  final int page;
  ObservationType observationType;

  CreateNewObservationTypeEvent(
      {required this.page, required this.observationType});
}

class PageChangeEvent extends ObservationTypeEvents {
  final int page;
  ObservationType? observationType;

  PageChangeEvent({required this.page, this.observationType});
}

class UpdateObservationTypeEvent extends ObservationTypeEvents {
  final int page;
  ObservationType observationType;

  UpdateObservationTypeEvent({required this.page, required this.observationType});
}

class ObservationTypeSelectedEvent extends ObservationTypeEvents {
  ObservationType observationType;

  ObservationTypeSelectedEvent({required this.observationType});
}

class SeverityLevelSelectedEvent extends ObservationTypeEvents {
  SeverityLevel severityLevel;

  SeverityLevelSelectedEvent({required this.severityLevel});
}

class VisibilityTypeSelectedEvent extends ObservationTypeEvents {
  VisibilityType visibilityType;

  VisibilityTypeSelectedEvent({required this.visibilityType});
}
class DeleteObservationTypeEvent extends ObservationTypeEvents {
  final int page;
  int id;

  DeleteObservationTypeEvent({required this.page, required this.id});
}

class ObservationTypeLoadingEvent extends ObservationTypeEvents {}

class GetObservationTypeByIdEvent extends ObservationTypeEvents {
  int? id;

  GetObservationTypeByIdEvent({required this.id});
}

class CreateObservationTypeEvent extends ObservationTypeEvents {
  final int page;
  CreateObservationTypeEvent({required this.page});
}
