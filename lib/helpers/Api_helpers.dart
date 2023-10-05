import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sky_scrapper/modals/Weather_modals.dart';

class ApiHelper {
  ApiHelper._();

  static final ApiHelper apiHelper = ApiHelper._();

  String Api =
      "https://api.openweathermap.org/data/2.5/weather?appid=217d9466fcece181f108ef7574f237b4&units=metric";

  Future<Weather?> getWeatherData({required String location}) async {
    http.Response response = await http.get(
      Uri.parse("${Api}&q=$location"),
    );

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      Weather weather = Weather.fromMap(data: data);

      return weather;
    } else {
      return null;
    }
  }
}
