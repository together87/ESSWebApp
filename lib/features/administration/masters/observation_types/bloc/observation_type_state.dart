
import '../../../../../common_libraries.dart';
import '../../severity_level/data/model/severityLevel.dart';
import '../data/model/observation_type_response.dart';
import '../data/model/visibility_type.dart';

class ObservationTypeState extends Equatable {
  final List<ObservationType> observationTypeList;
  final List<SeverityLevel> severityLevelList;
  final List<VisibilityType> visibilityTypeList;
  final SeverityLevel? selectedSeverityLevel;
  final VisibilityType? selectedVisibilityType;
  final EntityStatus? crudStatus;
  final ObservationType? selectedObservationType;
  final int? page;
  final String message;
  final bool statechange;
  const ObservationTypeState(
      {this.observationTypeList = const [],
      this.severityLevelList = const [],
      this.visibilityTypeList = const [],
      this.crudStatus = EntityStatus.initial,
      this.selectedObservationType,
      this.selectedSeverityLevel,
      this.selectedVisibilityType,
      this.page = 0,
      this.statechange = true,
      this.message = ''});

  @override
  List<Object?> get props => [
        observationTypeList,
        severityLevelList,
        visibilityTypeList,
        crudStatus,
        selectedObservationType,
        selectedSeverityLevel,
        selectedVisibilityType,
        page,
        statechange,
        message
      ];

  ObservationTypeState copyWith(
      {List<ObservationType>? observationTypeList,
      List<SeverityLevel>? severityLevelList,
      List<VisibilityType>? visibilityTypeList,
      EntityStatus? crudStatus,
      SeverityLevel? selectedSeverityLevel,
      VisibilityType? selectedVisibilityType,
      ObservationType? selectedObservationType,
      int? page,
      bool? statechange,
      String? message}) {
    return ObservationTypeState(
        observationTypeList: observationTypeList ?? this.observationTypeList,
        severityLevelList: severityLevelList ?? this.severityLevelList,
        visibilityTypeList: visibilityTypeList ?? this.visibilityTypeList,
        crudStatus: crudStatus ?? this.crudStatus,
        selectedObservationType:
            selectedObservationType ?? this.selectedObservationType,
        selectedSeverityLevel:
            selectedSeverityLevel,
        selectedVisibilityType:
            selectedVisibilityType ,
        page: page ?? this.page,
        statechange: statechange ?? this.statechange,
        message: message ?? '');
  }
}
