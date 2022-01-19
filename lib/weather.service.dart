//http://api.openweathermap.org/data/2.5/forecast?q=%D0%A1%D1%82%D0%B0%D0%B2%D1%80%D0%BE%D0%BF%D0%BE%D0%BB%D1%8C&units=metric&cnt=8&appid=3c12231ee84d39e9bf87449b1ec09de1
//http://api.openweathermap.org/data/2.5/forecast?q=%D0%A1%D1%82%D0%B0%D0%B2%D1%80%D0%BE%D0%BF%D0%BE%D0%BB%D1%8C&units=metric&cnt=21&appid=3c12231ee84d39e9bf87449b1ec09de1

import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:weather/common/weather.dart';

import 'common/consts.dart';

class WeatherService {
  static Future getCurrentDay(String cityName) async {
    try {
      var count = _calculateHourSlice();
      var response = await Dio().get(
          'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=metric&cnt=$count&appid=$apiKey');
      if (response.statusCode == 200) {
        return _parseResponse(response.data);
      }
    } catch (e) {
      return Future.error((e as DioError).message);
    }
  }

  static Future getThreeDays(String cityName) async {
    try {
      var count = _calculateDaySlice();
      var response = await Dio().get(
          'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=metric&cnt=$count&appid=$apiKey');
      if (response.statusCode == 200) {
        return _parseResponseToList(response.data);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  static int _calculateHourSlice() {
    var _currentDt = DateTime.now();

    return 8 - _currentDt.hour ~/ 3;
  }

  static int _calculateDaySlice() {
    var _currentDt = DateTime.now();
    return 22 - (8 - _currentDt.hour ~/ 3);
  }

  static List<Weather>? _parseResponse(Json json) {
    List<Weather>? weather;
    if (json['cnt'] > 0) {
      weather = <Weather>[];

      for (var item in (json['list'] as List)) {
        weather.add(Weather.fromJson(item));
      }
    }

    return weather;
  }

  static List<List<Weather>>? _parseResponseToList(Json json) {
    List<Weather>? weatherPrepare;
    List<List<Weather>>? weather;
    if (json['cnt'] > 0) {
      weather = [];
      weatherPrepare = <Weather>[];
      for (var item in (json['list'] as List)) {
        weatherPrepare.add(Weather.fromJson(item));
      }
      weather.add(weatherPrepare.take(weatherPrepare.length - 16).toList());
      weather.add(weatherPrepare
          .getRange(weatherPrepare.length - 16, weatherPrepare.length - 16 + 8)
          .toList());
      weather.add(weatherPrepare
          .getRange(
              weatherPrepare.length - 16 + 8, weatherPrepare.length - 16 + 16)
          .toList());
    }
    return weather;
  }
}
