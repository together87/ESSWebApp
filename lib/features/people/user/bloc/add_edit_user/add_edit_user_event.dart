part of 'add_edit_user_bloc.dart';

abstract class AddEditUsersEvent extends Equatable {
  const AddEditUsersEvent();

  @override
  List<Object?> get props => [];
}

class AddEditUserLoaded extends AddEditUsersEvent {
  final String userId;
  const AddEditUserLoaded({required this.userId});
  @override
  List<Object> get props => [userId];
}

class AddEditUserFirstNameChanged extends AddEditUsersEvent {
  final String firstName;
  const AddEditUserFirstNameChanged({required this.firstName});

  @override
  List<Object> get props => [firstName];
}

class AddEditUserTitleNameChanged extends AddEditUsersEvent {
  final String userTitle;
  const AddEditUserTitleNameChanged({required this.userTitle});

  @override
  List<Object> get props => [userTitle];
}

class AddEditUserPhoneChanged extends AddEditUsersEvent {
  final String userPhone;
  const AddEditUserPhoneChanged({required this.userPhone});

  @override
  List<Object> get props => [userPhone];
}

class AddEditUserEmailNameChanged extends AddEditUsersEvent {
  final String email;
  const AddEditUserEmailNameChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class AddEditUserLastNameChanged extends AddEditUsersEvent {
  final String lastName;
  const AddEditUserLastNameChanged({required this.lastName});

  @override
  List<Object> get props => [lastName];
}

/// event to add user
class AddEditUserAdded extends AddEditUsersEvent {
  const AddEditUserAdded();

  @override
  List<Object> get props => [];
}

/// event to edit project
class AddEditUserEdited extends AddEditUsersEvent {
  final int userId;
  const AddEditUserEdited({required this.userId});

  @override
  List<Object> get props => [userId];
}

class AddEditUserSiteListLoaded extends AddEditUsersEvent {}

class AddEditUserRoleListLoaded extends AddEditUsersEvent {}

class AddEditUserRoleChanged extends AddEditUsersEvent {
  final Role role;
  const AddEditUserRoleChanged({required this.role});

  @override
  List<Object?> get props => [role];
}

class AddEditUserItemSiteChanged extends AddEditUsersEvent {
  final Site site;
  const AddEditUserItemSiteChanged({required this.site});

  @override
  List<Object> get props => [site];
}
