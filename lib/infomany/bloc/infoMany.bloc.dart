import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/common/weather.dart';

import '../../weather.service.dart';
import 'infoMany.event.dart';
import 'infoMany.state.dart';

class InfoManyBloc extends Bloc<InfoManyEvent, InfoManyState> {
  InfoManyBloc(InfoManyState initialState) : super(initialState) {
    on<EInfoManyLoading>(_onLoading);
  }

  void _onLoading(
    EInfoManyLoading event,
    Emitter<InfoManyState> emit,
  ) async {
    try {
      var weather = await WeatherService.getThreeDays(event.cityName);
      if (weather is List<List<Weather>>) {
        emit(InfoManyLoaded(weather));
      } else {
        emit(InfoManyError(weather));
      }
    } catch (e) {
      emit(InfoManyError(e));
    }
  }
}
