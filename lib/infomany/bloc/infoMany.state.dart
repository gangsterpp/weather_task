import 'package:equatable/equatable.dart';
import 'package:weather/common/weather.dart';

abstract class InfoManyState extends Equatable {
  const InfoManyState();
  @override
  List<Object?> get props => [];
}

class InfoManyInit extends InfoManyState {}

class InfoManyLoading extends InfoManyState {}

class InfoManyLoaded extends InfoManyState {
  const InfoManyLoaded(this.weather);
  final List<List<Weather>> weather;
  @override
  List<Object?> get props => [weather];
}

class InfoManyError extends InfoManyState {
  const InfoManyError(this.errorMsg);
  final Object? errorMsg;
  @override
  List<Object?> get props => [errorMsg];
}
