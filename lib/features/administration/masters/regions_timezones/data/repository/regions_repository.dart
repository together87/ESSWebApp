import 'dart:convert';

import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/sub_region.dart';
import 'package:ecosys_safety/features/administration/masters/regions_timezones/data/model/time_zone_create.dart';

import '../model/region.dart';
import '../model/time_zone.dart';
import '/data/repository/repository.dart';

import '/data/model/model.dart';

class RegionsRepository extends BaseRepository {
  RegionsRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/regions');

  Future<List<Region>> getAllRegions() async {
    Response response = await super.get(url);
    if (response.statusCode == 200) {
      final regions = List<Region>.from(
          jsonDecode(response.body).map((e) => Region.fromMap(e)));

      return regions;
    }
    throw Exception();
  }

  Future<Region> getRegionById(String regionId) async {
    Response response = await super.get('$url/$regionId');

    if (response.statusCode == 200) {
      return Region.fromJson(jsonDecode(response.body));
    }
    throw Exception('');
  }

  Future<List<SubRegion>> getSubRegiForRegion(int regionId) async {
    Response response = await super.get('$url/$regionId/subregions');

    if (response.statusCode == 200) {
      final List<SubRegion> subRegions = List.from(
        jsonDecode(response.body),
      ).map((e) => SubRegion.fromMap(e)).toList();
      return subRegions;
    }
    throw Exception();
  }

  Future<List<TimeZone>> getTimeZonesForRegion(int regionId) async {
    Response response = await super.get('$url/$regionId/mytimezones');

    if (response.statusCode == 200) {
      final List<TimeZone> timeZones = List.from(
        jsonDecode(response.body),
      ).map((e) => TimeZone.fromMap(e)).toList();
      return timeZones;
    }
    throw Exception();
  }

  Future<List<TimeZone>> getCreateTimezonesForRegion(int regionId) async {
    Response response = await super.get('$url/$regionId/timezones');

    if (response.statusCode == 200) {
      final List<TimeZone> timeZones = List.from(
        jsonDecode(response.body),
      ).map((e) => TimeZone.fromMap(e)).toList();
      return timeZones;
    }
    throw Exception();
  }

  Future<EntityResponse> addSubRegion(SubRegion region) async {
    Response response = await super.post(
      "$url/${region.parentId}/addsubregion",
      body: region.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse.fromString(response.body);
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

  Future<EntityResponse> editRegion(Region region) async {
    Response response = await super.put(
      url,
      body: region.toJson(),
    );
    if (response.statusCode == 200) {
      return EntityResponse.fromString(response.body);
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

  Future<EntityResponse> deleteRegion(String regionId) async {
    Response response = await super.delete('$url/$regionId');

    if (response.statusCode == 200) {
      return EntityResponse(
        statusCode: response.statusCode,
        isSuccess: true,
        message: 'Region deleted successfully',
      );
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

  Future<EntityResponse> editSubRegion(SubRegion region) async {
    int id = region.parentId!;
    Response response = await super.put(
      "$url/${region.parentId}/updatesubregion",
      body: region.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse.fromString(response.body);
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

  Future<EntityResponse> deleteSubRegion(int id) async {
    Response response = await super.delete("$url/subregions/$id");

    if (response.statusCode == 200) {
      return EntityResponse.fromString(response.body);
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

  Future<EntityResponse> addTimezone(TimeZoneCreate timeZoneCreate) async {
    Response response = await super.post(
      '$url/createtimezone',
      body: timeZoneCreate.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse(
        statusCode: response.statusCode,
        isSuccess: true,
        message: response.body,
      );
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

  Future<EntityResponse> editTimezone(TimeZone timeZone) async {
    Response response = await super.put(
      "$url/timezone",
      body: timeZone.toJson(),
    );

    if (response.statusCode == 200) {
      return EntityResponse.fromString(response.body);
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }

  Future<EntityResponse> deleteTimezone(int id) async {
    Response response = await super.delete("$url/timezone/$id");

    if (response.statusCode == 200) {
      return EntityResponse.fromString(response.body);
    } else {
      return EntityResponse.fromJson(response.body);
    }
  }
}
