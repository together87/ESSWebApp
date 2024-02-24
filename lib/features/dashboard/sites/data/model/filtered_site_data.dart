import '/common_libraries.dart';

class FilteredSiteData extends Equatable {
  final List<Sites> data;
  const FilteredSiteData({
    required this.data,
  });

  @override
  List<Object?> get props => [
        data,
      ];

  factory FilteredSiteData.fromMap(Map<String, dynamic> map) {
    return FilteredSiteData(
      data: List<Sites>.from(
        (map['data']).map<Sites>(
          (x) => Sites.fromMap(x),
        ),
      ),
    );
  }

  factory FilteredSiteData.fromJson(String source) => FilteredSiteData.fromMap(json.decode(source) as Map<String, dynamic>);
}
