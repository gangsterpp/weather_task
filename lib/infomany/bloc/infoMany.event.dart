import 'package:equatable/equatable.dart';

abstract class InfoManyEvent extends Equatable {
  const InfoManyEvent();
  @override
  List<Object?> get props => [];
}

class EInfoManyInit extends InfoManyEvent {}

class EInfoManyLoading extends InfoManyEvent {
  const EInfoManyLoading(this.cityName);
  final String cityName;
  @override
  List<Object?> get props => [cityName];
}
