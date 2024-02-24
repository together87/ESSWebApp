import '../../../../../common_libraries.dart';

class UserData {
  UserData({
    required this.message,
    required this.data,
  });
  late final String message;
  late final User data;

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      data: User.fromMap(map['data']),
      message: map['message'],
    );
  }

  factory UserData.fromJson(String source) => UserData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class User extends Entity {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String title;
  final String siteName;
  final int? siteId;
  final String roleName;
  final int? userRoleId;
  final String timeZoneName;
  final String timeZoneId;
  final String sites;
  final bool inviteSent;

  const User({
    super.id,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.mobileNumber = '',
    this.title = '',
    this.siteName = '',
    this.siteId,
    this.roleName = '',
    this.userRoleId,
    this.timeZoneId = '',
    this.timeZoneName = '',
    this.sites = '',
    this.inviteSent = false,
    super.active,
    super.createdByUserName,
    super.createdOn,
    super.lastModifiedByUserName,
    super.lastModifiedOn,
    super.deactivationUserName,
    super.deactivationDate,
    super.columns = const [],
    super.deleted,
  }) : super(name: '$firstName $lastName');

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [
        ...super.props,
        firstName,
        lastName,
        email,
        mobileNumber,
        title,
        siteName,
        siteId,
        roleName,
        userRoleId,
        timeZoneName,
        timeZoneId,
        sites,
        inviteSent,
      ];

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? mobileNumber,
    String? title,
    String? siteName,
    int? siteId,
    String? createdOn,
    String? createdByUserName,
    String? lastModifiedByUserName,
    String? lastModifiedOn,
    String? roleName,
    int? userRoleId,
    String? timeZoneName,
    String? timeZoneId,
    String? sites,
    String? deactivationUserName,
    String? deactivationDate,
    bool? inviteSent,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      title: title ?? this.title,
      siteId: siteId ?? this.siteId,
      siteName: siteName ?? this.siteName,
      createdByUserName: createdByUserName ?? this.createdByUserName,
      createdOn: createdOn ?? this.createdOn,
      lastModifiedByUserName: lastModifiedByUserName ?? this.lastModifiedByUserName,
      lastModifiedOn: lastModifiedOn ?? this.lastModifiedOn,
      roleName: roleName ?? this.roleName,
      userRoleId: userRoleId ?? this.userRoleId,
      timeZoneName: timeZoneName ?? this.timeZoneName,
      timeZoneId: timeZoneId ?? this.timeZoneId,
      sites: sites ?? this.sites,
      inviteSent: inviteSent ?? this.inviteSent,
      deactivationUserName: deactivationUserName ?? this.deactivationUserName,
      deactivationDate: deactivationDate ?? this.deactivationDate,
    );
  }

  @override
  Map<String, dynamic> tableItemsToMap() {
    return {
      'First Name': firstName,
      'Last Name': lastName,
      'Title': title,
      'Mobile Number': mobileNumber,
      'Email': email,
      'Action': Icons.delete,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobileNumber': mobileNumber,
      'title': title,
      'siteId': siteId,
      'userRoleId': userRoleId,
    };
    if (id != null) {
      map.addEntries([MapEntry('id', id)]);
    }
    return map;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return User(
      id: entity.id,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      title: map['title'] ?? '',
      siteName: map['siteName'] ?? '',
      siteId: map['siteId'] ?? '',
      roleName: map['roleName'] ?? '',
      userRoleId: map['userRoleId'] ?? '',
      timeZoneId: map['timeZoneId'] ?? '',
      timeZoneName: map['timeZoneName'] ?? '',
      inviteSent: map['inviteSent'],
      active: entity.active,
      createdByUserName: entity.createdByUserName,
      createdOn: entity.createdOn,
      lastModifiedByUserName: entity.lastModifiedByUserName,
      lastModifiedOn: entity.lastModifiedOn,
      deactivationDate: entity.deactivationDate,
      deactivationUserName: entity.deactivationUserName,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}
