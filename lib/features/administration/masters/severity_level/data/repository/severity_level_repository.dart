import 'dart:convert';

import '/data/model/entity.dart';
import 'package:ecosys_safety/features/administration/masters/severity_level/data/model/severityLevel.dart';
import '/data/repository/repository.dart';

class SeverityLevelRepository extends BaseRepository {
  SeverityLevelRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/severitylevel');

  Future<List<SeverityLevel>> getAllSeverityLevels() async {
    Response response = await super.get(url);
    if (response.statusCode == 200) {
      final severityLevelList = List<SeverityLevel>.from(
          jsonDecode(response.body).map((e) => SeverityLevel.fromMap(e)));
      return severityLevelList;
    }
    throw Exception();
  }

  Future<SeverityLevel> getSeverityLevelById(int severitylevelId) async {
    Response response = await super.get('$url/$severitylevelId');
    if (response.statusCode == 200) {
      return SeverityLevel.fromJson(jsonDecode(response.body));
    }
    throw Exception();
  }

  Future<EntityResponse> createSeverityLevel(
      SeverityLevel severitylevel) async {
    Response response = await super.post(
      url,
      body: severitylevel.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse.fromString(response.body);
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

  Future<EntityResponse> updateSeverityLevel(
      SeverityLevel severitylevel) async {
    Response response = await super.put(
      url,
      body: severitylevel.toJson(),
    );
    if (response.statusCode == 200) {
      return EntityResponse.fromString(response.body);
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

  Future<EntityResponse> deleteSeverityLevel(int severitylevelId) async {
    Response response = await super.delete('$url/$severitylevelId');

    if (response.statusCode == 200) {
      return EntityResponse(
        statusCode: response.statusCode,
        isSuccess: true,
        message: 'Severity Level deleted successfully',
      );
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }
}
