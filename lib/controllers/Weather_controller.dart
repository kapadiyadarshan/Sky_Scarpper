import 'package:flutter/material.dart';
import 'package:sky_scrapper/helpers/Api_helpers.dart';
import 'package:sky_scrapper/modals/Weather_modals.dart';

class WeatherController extends ChangeNotifier {
  Weather? weather;
  List<Weather?> LocationList = [];

  WeatherController() {
    getData();
    getLocationWeatherData();
  }

  getData({String location = "Surat"}) async {
    weather = await ApiHelper.apiHelper.getWeatherData(location: location);
    notifyListeners();
  }

  getLocationWeatherData() {
    LocationList = ApiHelper.apiHelper.getLocationListData();
    notifyListeners();
  }
}
