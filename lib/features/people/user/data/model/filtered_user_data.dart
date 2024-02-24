import '/common_libraries.dart';

class FilteredUsersData extends Equatable {
  final List<User> data;
  const FilteredUsersData({
    required this.data,
  });

  @override
  List<Object?> get props => [
        data,
      ];

  factory FilteredUsersData.fromMap(Map<String, dynamic> map) {
    return FilteredUsersData(
      data: List<User>.from(
        (map['data']).map<User>(
          (x) => User.fromMap(x),
        ),
      ),
    );
  }

  factory FilteredUsersData.fromJson(String source) => FilteredUsersData.fromMap(json.decode(source) as Map<String, dynamic>);
}
