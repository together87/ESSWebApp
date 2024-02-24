
import 'dart:convert';

import '../../../../../../data/model/entity.dart';
import '../../../../../../data/repository/base_repository.dart';
import '../model/observation_type_response.dart';
import '../model/visibility_type.dart';

class ObservationTypeRepository extends BaseRepository {
  ObservationTypeRepository({required super.token, required super.authBloc})
      : super(url: '/api/observationtypes');

  Future<List<ObservationType>> getAllObservationTypes() async {
    Response response = await super.get(url);
    if (response.statusCode == 200) {
      ObservationTypeResponse observationTypeReponse =
          ObservationTypeResponse.fromJson(response.body);
      return observationTypeReponse.dataList!;
    }
    throw Exception();
  }
  Future<List<VisibilityType>> getAllVisibilityTypes() async {
    Response response = await super.get('$url/visiblitytypes');
    if (response.statusCode == 200) {
      VisibilityTypeResponse visibilityTypeReponse =
          VisibilityTypeResponse.fromJson(response.body);
      return visibilityTypeReponse.dataList!;
    }
    throw Exception();
  }
  Future<ObservationType> getObservationTypeById(int observationTypeId) async {
    Response response = await super.get('$url/$observationTypeId');
    if (response.statusCode == 200) {
      return ObservationType.fromJson(jsonDecode(response.body));
    }
    throw Exception();
  }


  Future<EntityResponse> createObservationType(
      ObservationType observationType) async {
    Response response = await super.post(
      url,
      body: observationType.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

  Future<EntityResponse> updateObservationType(
      ObservationType observationType) async {
    Response response = await super.put(
      url,
      body: observationType.toJson(),
    );
    if (response.statusCode == 200) {
      return EntityResponse.fromJson(response.body);
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

  Future<EntityResponse> deleteObservationType(int id) async {
    Response response = await super.delete('$url/$id');

    if (response.statusCode == 200) {
      return EntityResponse(
        statusCode: response.statusCode,
        isSuccess: true,
        message: 'Observation Type deleted successfully',
      );
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

}
