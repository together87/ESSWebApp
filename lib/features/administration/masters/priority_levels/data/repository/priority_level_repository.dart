import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/data/model/priorityType.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/data/model/priorityResponse.dart';
import '../model/priority_level_response.dart';

class PriorityLevelRepository extends BaseRepository {
  PriorityLevelRepository({required super.token, required super.authBloc})
      : super(url: '/api/prioritylevels');

  Future<List<PriorityLevel>> getAllPriorityLevels() async {
    Response response = await super.get(url);
    if (response.statusCode == 200) {
      PriorityLevelResponse priorityLevelReponse =
          PriorityLevelResponse.fromJson(response.body);
      return priorityLevelReponse.dataList!;
    }
    throw Exception();
  }

  Future<PriorityLevel> getPriorityLevelById(int priorityLevelId) async {
    Response response = await super.get('$url/$priorityLevelId');
    if (response.statusCode == 200) {
      return PriorityLevel.fromJson(jsonDecode(response.body));
    }
    throw Exception();
  }

  Future<PriorityType> getPriorityTypeById(int priorityTypeId) async {
    Response response = await super.get('$url/$priorityTypeId/getprioritytype');
    if (response.statusCode == 200) {
      
      PriorityResponse priorityReponse =
          PriorityResponse.fromJson2(response.body);
      return priorityReponse.data!;
    }
    throw Exception();
  }

  Future<EntityResponse> createPriorityLevel(
      PriorityLevel priorityLevel) async {
    Response response = await super.post(
      url,
      body: priorityLevel.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

  Future<EntityResponse> updatePriorityLevel(
      PriorityLevel priorityLevel) async {
    Response response = await super.put(
      url,
      body: priorityLevel.toJson(),
    );
    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

  Future<EntityResponse> deletePriorityLevel(int id) async {
    Response response = await super.delete('$url/$id');

    if (response.statusCode == 200) {
      return EntityResponse(
        statusCode: response.statusCode,
        isSuccess: true,
        message: 'Priority level deleted successfully',
      );
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

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
}
