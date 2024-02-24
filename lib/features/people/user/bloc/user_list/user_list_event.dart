part of 'user_list_bloc.dart';

abstract class UserListEvents extends Equatable {
  const UserListEvents();

  @override
  List<Object?> get props => [];
}

class UserListFiltered extends UserListEvents {
  const UserListFiltered();

  @override
  List<Object?> get props => [];
}

class UserDetailUserDeleted extends UserListEvents {
  final String userId;
  const UserDetailUserDeleted({required this.userId});

  @override
  List<Object> get props => [userId];
}
