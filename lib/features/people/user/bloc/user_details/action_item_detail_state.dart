// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'action_item_detail_bloc.dart';

class UserDetailState extends Equatable {
  final EntityStatus status;
  final EntityStatus detailsLoader;
  final String message;
  final String title;
  final User? user;

  const UserDetailState({
    this.title = '',
    this.user,
    this.status = EntityStatus.initial,
    this.detailsLoader = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        title,
        user,
        status,
        detailsLoader,
        message,
      ];

  UserDetailState copyWith({
    User? user,
    EntityStatus? status,
    EntityStatus? detailsLoader,
    String? message,
    String? title,
  }) {
    return UserDetailState(
      title: title ?? this.title,
      detailsLoader: detailsLoader ?? this.detailsLoader,
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }
}
