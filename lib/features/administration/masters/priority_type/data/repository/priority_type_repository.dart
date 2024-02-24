import 'dart:convert';

import '/data/model/entity.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/data/model/priorityType.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/data/model/priorityResponse.dart';
import '/data/repository/repository.dart';

class PriorityTypeRepository extends BaseRepository {
  PriorityTypeRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/prioritylevels');

  Future<List<PriorityType>> getAllPriorityTypes() async {
    Response response = await super.get('$url/getprioritytype');
    if (response.statusCode == 200) {
      PriorityResponse priorityReponse =
          PriorityResponse.fromJson(response.body);
      // final priorityTypeList = List<PriorityType>.from(
      //     jsonDecode(response.body).map((e) => PriorityType.fromMap(e)));
      // return priorityTypeList;
      return priorityReponse.dataList!;
    }
    throw Exception();
  }

  Future<PriorityType> getPriorityTypeById(int priorityTypeId) async {
    Response response = await super.get('$url/$priorityTypeId/getprioritytype');
    if (response.statusCode == 200) {
      return PriorityType.fromJson(jsonDecode(response.body));
    }
    throw Exception();
  }

  Future<EntityResponse> createPriorityType(PriorityType priorityType) async {
    Response response = await super.post(
      '$url/addprioritytype',
      body: priorityType.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

  Future<EntityResponse> updatePriorityType(PriorityType priorityType) async {
    Response response = await super.put(
      '$url/updateprioritytype',
      body: priorityType.toJson(),
    );
    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

  Future<EntityResponse> deletePriorityType(int priorityTypeId) async {
    Response response =
        await super.delete('$url/$priorityTypeId/deleteprioritytype');

    if (response.statusCode == 200) {
      return EntityResponse(
        statusCode: response.statusCode,
        isSuccess: true,
        message: 'Priority type deleted successfully',
      );
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }
}
