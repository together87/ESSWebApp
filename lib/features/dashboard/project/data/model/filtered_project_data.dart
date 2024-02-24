import '/common_libraries.dart';

class FilteredProjectData extends Equatable {
  final List<Project> data;
  const FilteredProjectData({
    required this.data,
  });

  @override
  List<Object?> get props => [
        data,
      ];

  factory FilteredProjectData.fromMap(Map<String, dynamic> map) {
    return FilteredProjectData(
      data: List<Project>.from(
        (map['data']).map<Project>(
          (x) => Project.fromMap(x),
        ),
      ),
    );
  }

  factory FilteredProjectData.fromJson(String source) => FilteredProjectData.fromMap(json.decode(source) as Map<String, dynamic>);
}
