import '/common_libraries.dart';

class UsersRepository extends BaseRepository {
  UsersRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/users');

  Future<FilteredUsersData> getFilteredUserList() async {
    Response response = await super.get(url);

    if (response.statusCode == 200) {
      return FilteredUsersData.fromJson(response.body);
    }
    throw Exception();
  }

  Future<List<Role>> getUserRoles() async {
    Response response = await super.get('$url/roles');

    if (response.statusCode == 200) {
      return RoleData.fromJson(response.body).data;
    }
    return [];
  }

  Future<List<Director>> getUserRoleByRoleList(String name) async {
    Map<String, String> map = {'roleName': name};

    Response response = await super.get('$url/items', map);
    if (response.statusCode == 200) {
      return DirectorData.fromJson(response.body).data;
    }
    throw Exception();
  }

  /// get user by id
  Future<User> getUserById(
    String userId,
  ) async {
    Response response = await super.get('$url/$userId');
    if (response.statusCode == 200) {
      return UserData.fromJson(response.body).data;
    }
    throw Exception();
  }

  // add user
  Future<EntityResponse> addUser(User user) async {
    Response response = await super.post(url, body: user.toJson());

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse.fromJson(response.body);
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  // edit user
  Future<EntityResponse> editUser(User user) async {
    Response response = await super.put(
      url,
      body: user.toJson(),
    );

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  // delete user
  Future<EntityResponse> deleteUser(String userId) async {
    Response response = await super.delete('$url/$userId');

    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          message: response.body,
        );
      }
      return EntityResponse.fromJson(response.body);
    }

    throw Exception();
  }
}
