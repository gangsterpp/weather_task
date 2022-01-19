import 'dart:ffi';

import 'package:equatable/equatable.dart';

import 'consts.dart';

class Weather extends Equatable {
  const Weather(this.datetime, this.temp, this.humidity, this.windSpeed);
  final DateTime datetime;
  final dynamic temp;
  final int humidity;
  final double windSpeed;

  factory Weather.fromJson(Json json) {
    return Weather(DateTime.parse(json['dt_txt']), json['main']['temp'],
        json['main']['humidity'], json['wind']['speed']);
  }
  @override
  List<Object?> get props => [datetime, temp, humidity, windSpeed];
}
