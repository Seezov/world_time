import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String flag;
  String url;
  String? time;
  bool? isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    Response response = await get(Uri.http("worldtimeapi.org", "/api/timezone/$url"));
    Map data = jsonDecode(response.body);

    DateTime now = DateTime.parse(data["utc_datetime"]);
    now = now.add(Duration(hours: int.parse(data["utc_offset"].substring(1,3))));
    isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
    time = DateFormat.jm().format(now);
  }
}