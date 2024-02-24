part of 'user_list_bloc.dart';

class UserListState extends Equatable {
  final EntityStatus userCrud;
  final EntityStatus status;
  final String message;
  final String title;

  /// loaded project list
  final List<User> userList;

  const UserListState({
    this.userCrud = EntityStatus.initial,
    this.status = EntityStatus.initial,
    this.message = '',
    this.title = '',
    this.userList = const [],
  });

  @override
  List<Object?> get props => [
        userCrud,
        status,
        message,
        title,
        userList,
      ];

  UserListState copyWith({
    EntityStatus? projectCrud,
    EntityStatus? status,
    String? message,
    String? title,
    List<User>? userList,
  }) {
    return UserListState(
      userCrud: projectCrud ?? this.userCrud,
      status: status ?? this.status,
      message: message ?? this.message,
      title: title ?? this.title,
      userList: userList ?? this.userList,
    );
  }
}
