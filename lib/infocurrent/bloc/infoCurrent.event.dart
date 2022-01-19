import 'package:equatable/equatable.dart';

abstract class InfoCurrentEvent extends Equatable {
  const InfoCurrentEvent();
  @override
  List<Object?> get props => [];
}

class EInfoCurrentInit extends InfoCurrentEvent {}

class EInfoCurrentLoading extends InfoCurrentEvent {
  const EInfoCurrentLoading(this.cityName);
  final String cityName;
  @override
  List<Object?> get props => [cityName];
}
