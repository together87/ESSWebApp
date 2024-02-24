import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/severity_level/data/model/severityLevel.dart';

class SeveritylevelState extends Equatable {
  final List<SeverityLevel> severityLevelList;
  final EntityStatus? severitylevelCrud;
  final SeverityLevel? selectedSeverityLevel;
  final int? severityPage;
  final String message;
  const SeveritylevelState({
    this.severityLevelList = const [],
    this.severitylevelCrud = EntityStatus.initial,
    this.severityPage = 0,
    this.message = "",
    this.selectedSeverityLevel,
  });

  @override
  List<Object?> get props => [
        severityLevelList,
        severitylevelCrud,
        severityPage,
        message,
        selectedSeverityLevel,
      ];
  SeveritylevelState copyWith({
    List<SeverityLevel>? severityLevelList,
    EntityStatus? severitylevelCrud,
    int? severityPage,
    String? message,
    SeverityLevel? selectedSeverityLevel,
  }) {
    return SeveritylevelState(
      severityLevelList: severityLevelList ?? this.severityLevelList,
      severitylevelCrud: severitylevelCrud ?? this.severitylevelCrud,
      severityPage: severityPage ?? this.severityPage,
      selectedSeverityLevel:
          selectedSeverityLevel??this.selectedSeverityLevel ,
      message: message ?? '',
    );
  }
}
