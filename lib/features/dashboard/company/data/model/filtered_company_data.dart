import '/common_libraries.dart';

class FilteredCompanyData extends Equatable {
  final List<Company> data;
  const FilteredCompanyData({
    required this.data,
  });

  @override
  List<Object?> get props => [
        data,
      ];

  factory FilteredCompanyData.fromMap(Map<String, dynamic> map) {
    return FilteredCompanyData(
      data: List<Company>.from(
        (map['data']).map<Company>(
          (x) => Company.fromMap(x),
        ),
      ),
    );
  }

  factory FilteredCompanyData.fromJson(String source) =>
      FilteredCompanyData.fromMap(json.decode(source) as Map<String, dynamic>);
}
