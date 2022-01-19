import 'package:equatable/equatable.dart';
import 'package:weather/common/weather.dart';

abstract class InfoCurrentState extends Equatable {
  const InfoCurrentState();
  @override
  List<Object?> get props => [];
}

class InfoCurrentInit extends InfoCurrentState {}

class InfoCurrentLoading extends InfoCurrentState {}

class InfoCurrentLoaded extends InfoCurrentState {
  const InfoCurrentLoaded(this.weather);
  final List<Weather> weather;
  @override
  List<Object?> get props => [weather];
}

class InfoCurrentError extends InfoCurrentState {
  const InfoCurrentError(this.errorMsg);
  final Object? errorMsg;
  @override
  List<Object?> get props => [errorMsg];
}
