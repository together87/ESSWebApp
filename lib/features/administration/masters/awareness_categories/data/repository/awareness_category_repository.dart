

import 'dart:convert';

import '../../../../../../data/model/entity.dart';
import '../../../../../../data/repository/base_repository.dart';
import '../model/awareness_category_response.dart';

class AwarenessCategoryRepository extends BaseRepository {
  AwarenessCategoryRepository({required super.token, required super.authBloc})
      : super(url: '/api/awarenesscategory');

  Future<List<AwarenessCategory>> getAllAwarenessCategorys() async {
    Response response = await super.get(url);
    if (response.statusCode == 200) {
      AwarenessCategoryResponse awarenessCategoryReponse =
          AwarenessCategoryResponse.fromJson(response.body);
      return awarenessCategoryReponse.dataList!;
    }
    throw Exception();
  }

  Future<AwarenessCategory> getAwarenessCategoryById(int awarenessCategoryId) async {
    Response response = await super.get('$url/$awarenessCategoryId');
    if (response.statusCode == 200) {
      return AwarenessCategory.fromJson(jsonDecode(response.body));
    }
    throw Exception();
  }
  Future<EntityResponse> createAwarenessCategory(
      AwarenessCategory awarenessCategory) async {
    Response response = await super.post(
      url,
      body: awarenessCategory.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

  Future<EntityResponse> updateAwarenessCategory(
      AwarenessCategory awarenessCategory) async {
    Response response = await super.put(
      url,
      body: awarenessCategory.toJson(),
    );
    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

  Future<EntityResponse> deleteAwarenessCategory(int id) async {
    Response response = await super.delete('$url/$id');

    if (response.statusCode == 200) {
      return EntityResponse(
        statusCode: response.statusCode,
        isSuccess: true,
        message: 'Awareness Category deleted successfully',
      );
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

}
