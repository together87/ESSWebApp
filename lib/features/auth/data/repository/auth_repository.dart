import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import '../../../../constants/uri.dart';
import '../../../../data/model/entity.dart';
import '../model/auth.dart';
import '../model/auth_user.dart';
import '../model/reset_password.dart';
import '/common_libraries.dart';

class AuthRepository {
  static String url = '/api/Auth/token';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'accept': '*/*',
  };

  Future<AuthUser> login(Auth auth) async {
    Response response = await post(
      Uri.https(ApiUri.host, url),
      headers: headers,
      body: auth.toJson(),
    );

    if (response.statusCode == 200) {
      return AuthUser.fromJson(response.body);
    }

    if (response.statusCode == 302) {
      throw HttpException(jsonDecode(response.body)['callbackUrl']);
    }
    throw Exception();
  }

  Future<void> logout() async {}

  Future<EntityResponse> forgotPassword(String email) async {
    Response response = await post(
      Uri.https(ApiUri.host, '/api/users/forgotpassword', {'email': email}),
    );

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: response.body,
      );
    }

    throw HttpException(response.body);
  }

  Future<EntityResponse> resetPassword(ResetPassword resetPassword) async {
    Response response = await post(
      Uri.https(ApiUri.host, '/api/users/resetpassword'),
      headers: headers,
      body: resetPassword.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse(
        isSuccess: true,
        message: response.body,
      );
    }

    throw HttpException(response.body);
  }
}
