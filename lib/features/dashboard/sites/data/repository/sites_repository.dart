import 'package:ecosys_safety/common_libraries.dart';
import 'package:http/http.dart' as http;

import '../../../../administration/masters/regions_timezones/data/model/model.dart';

class SitesRepository extends BaseRepository {
  SitesRepository({required super.token, required super.authBloc}) : super(url: '/api/site');

  Future<List<Sites>> getFilteredSitesList() async {
    Response response = await super.get(url);

    if (response.statusCode == 200) {
      final data = FilteredSiteData.fromJson(response.body).data;
      return data;
    }
    throw Exception();
  }

  Future<Sites> getSitesById(String sitesId) async {
    Response response = await super.get('$url/$sitesId');
    if (response.statusCode == 200) {
      return SitesData.fromJson(response.body).data;
    }
    throw Exception();
  }

  Future<EntityResponse> createSites(Sites sites) async {
    Response response = await super.post(
      url,
      body: sites.toJson(),
    );

    if (response.statusCode != 500) {
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> updateSites(Sites sites) async {
    Response response = await super.put(
      url,
      body: sites.toJson(),
    );
    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse.fromMap({
          'isSuccess': true,
          'message': response.body,
        });
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<EntityResponse> deleteSites(int id) async {
    final uri = Uri.https(ApiUri.host, url, <String, String>{"id": id.toString()});
    Response response = await http.delete(uri);
    if (response.statusCode != 500) {
      if (response.statusCode == 200) {
        return EntityResponse.fromMap({
          'isSuccess': true,
          'message': response.body,
        });
      }
      return EntityResponse.fromJson(response.body);
    }
    throw Exception();
  }

  Future<List<JsaMethod>> getJsaMethods() async {
    Response response = await super.get('$url/jsamethods');
    if (response.statusCode == 200) {
      JsaMethodResponse jsaMethodResponse = JsaMethodResponse.fromJson(response.body);
      return jsaMethodResponse.dataList!;
    }
    throw Exception();
  }

  Future<List<Regions>> getRegions() async {
    Response response = await super.get('api/regions/items');
    if (response.statusCode == 200) {
      RegionsResponse regionResponse = RegionsResponse.fromJson(response.body);
      return regionResponse.dataList!;
    }
    throw Exception();
  }

  Future<List<TimeZone>> getTimezones(int subRegionId) async {
    Response response = await super.get('api/regions/$subRegionId/mytimezones');
    if (response.statusCode == 200) {
      final List<TimeZone> timeZones = List.from(
        jsonDecode(response.body),
      ).map((e) => TimeZone.fromMap(e)).toList();
      return timeZones;
    }
    throw Exception();
  }

  Future<List<Site>> getSiteListForProject() async {
    Response response = await super.get("$url/items");
    if (response.statusCode == 200) {
      return SiteData.fromJson(response.body).data;
    }
    throw Exception();
  }
}
