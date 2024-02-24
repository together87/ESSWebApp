// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'action_item_detail_bloc.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

/// event to load the user detail
class UserDetailsLoaded extends UserDetailEvent {}
