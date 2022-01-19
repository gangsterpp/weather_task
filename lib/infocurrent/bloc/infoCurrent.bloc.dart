import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/common/weather.dart';

import 'package:weather/weather.service.dart';

import 'infoCurrent.event.dart';
import 'infoCurrent.state.dart';

class InfoCurrentBloc extends Bloc<InfoCurrentEvent, InfoCurrentState> {
  InfoCurrentBloc(InfoCurrentState initialState) : super(initialState) {
    on<EInfoCurrentLoading>(_onLoading);
  }

  void _onLoading(
    EInfoCurrentLoading event,
    Emitter<InfoCurrentState> emit,
  ) async {
    emit(InfoCurrentInit());
    try {
      var weather = await WeatherService.getCurrentDay(event.cityName);
      if (weather is List<Weather>) {
        emit(InfoCurrentLoaded(weather));
      } else {
        emit(InfoCurrentError(weather));
      }
    } catch (e) {
      emit(InfoCurrentError(e));
    }
  }
}
