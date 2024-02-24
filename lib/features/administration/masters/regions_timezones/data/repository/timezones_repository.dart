import 'dart:convert';

import '../model/time_zone.dart';
import '../model/time_zone_create.dart';
import '/common_libraries.dart';

class TimeZonesRepository extends BaseRepository {
  TimeZonesRepository({
    required super.token,
    required super.authBloc,
  }) : super(url: '/api/Timezones');

  Future<List<TimeZone>> getTimeZoneList() async {
    Response response = await super.get('$url/list');

    if (response.statusCode == 200) {
      return List.from(json.decode(response.body))
          .map((timeZoneMap) => TimeZone.fromMap(timeZoneMap))
          .toList();
    }
    throw Exception();
  }

  Future<List<TimeZone>> getAllTimeZones(int regionId) async {
    Response response = await super.get('/api/regions/$regionId/mytimezones');

    if (response.statusCode == 200) {
      final List<TimeZone> timeZones = List.from(
        jsonDecode(response.body),
      ).map((e) => TimeZone.fromMap(e)).toList();
      return timeZones;
    }
    return [];
  }
}
