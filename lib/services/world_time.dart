import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  late String time;
  String flag;
  String url;
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.https('worldtimeapi.org', '/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(0, 3);

      // print(datetime);
      // print(offset);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      print('now $now');
      print('api datetime ${data['datetime']}');

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      //bug format?
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('catch eror: $e');
      time = 'could not get time data';
    }
  }
}
