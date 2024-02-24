part of 'add_edit_user_bloc.dart';

class AddEditUsersState extends Equatable {
  final EntityStatus status;
  final EntityStatus detailsLoaded;
  final String message;
  final String title;

  ///user title
  final String userTitle;

  ///user phone
  final String userPhone;

  ///user first name
  final String firstName;
  final String firstNameValidationMessage;

  ///user first name
  final String lastName;
  final String lastNameValidationMessage;

  ///user email
  final String email;
  final String emailValidationMessage;

  /// site list
  final List<Site> siteList;

  /// site to create project
  final Site? site;
  final String siteValidationMessage;

  /// role list
  final List<Role> roleList;

  /// role
  final Role? role;
  final String roleValidationMessage;

  const AddEditUsersState({
    this.status = EntityStatus.initial,
    this.detailsLoaded = EntityStatus.initial,
    this.message = '',
    this.title = '',
    this.userTitle = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.userPhone = '',
    this.firstNameValidationMessage = '',
    this.lastNameValidationMessage = '',
    this.emailValidationMessage = '',
    this.siteValidationMessage = '',
    this.roleValidationMessage = '',
    this.roleList = const [],
    this.siteList = const [],
    this.site,
    this.role,
  });

  @override
  List<Object?> get props => [
        status,
        detailsLoaded,
        message,
        title,
        userTitle,
        firstName,
        lastName,
        email,
        userPhone,
        firstNameValidationMessage,
        lastNameValidationMessage,
        emailValidationMessage,
        siteValidationMessage,
        roleValidationMessage,
        roleList,
        siteList,
        site,
        role,
      ];

  User get user => User(
        firstName: firstName,
        lastName: lastName,
        title: userTitle,
        email: email,
        mobileNumber: userPhone,
        siteId: site!.id,
        userRoleId: role!.id,
      );

  AddEditUsersState copyWith({
    EntityStatus? status,
    EntityStatus? detailsLoaded,
    String? message,
    String? title,
    String? userTitle,
    String? userPhone,
    String? firstName,
    String? firstNameValidationMessage,
    String? lastName,
    String? lastNameValidationMessage,
    String? email,
    String? emailValidationMessage,
    String? siteValidationMessage,
    String? roleValidationMessage,
    List<Site>? siteList,
    Nullable<Site?>? site,
    List<Role>? roleList,
    Nullable<Role?>? role,
  }) {
    return AddEditUsersState(
      status: status ?? this.status,
      detailsLoaded: detailsLoaded ?? this.detailsLoaded,
      message: message ?? this.message,
      title: title ?? this.title,
      userTitle: userTitle ?? this.userTitle,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      userPhone: userPhone ?? this.userPhone,
      firstNameValidationMessage: firstNameValidationMessage ?? this.firstNameValidationMessage,
      lastNameValidationMessage: lastNameValidationMessage ?? this.lastNameValidationMessage,
      emailValidationMessage: emailValidationMessage ?? this.emailValidationMessage,
      siteValidationMessage: siteValidationMessage ?? this.siteValidationMessage,
      roleValidationMessage: roleValidationMessage ?? this.roleValidationMessage,
      roleList: roleList ?? this.roleList,
      siteList: siteList ?? this.siteList,
      site: site != null ? site.value : this.site,
      role: role != null ? role.value : this.role,
    );
  }
}
