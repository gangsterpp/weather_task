// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/common/app.dart';
import 'package:weather/infomany/bloc/infoMany.bloc.dart';
import 'package:weather/infomany/bloc/infoMany.event.dart';
import 'package:weather/infomany/bloc/infoMany.state.dart';

void main() {
  InfoManyBloc? firstBloc;
  setUp(() {
    firstBloc = InfoManyBloc(InfoManyInit());
  });
  tearDown(() => firstBloc?.close());

  test('Проверяю не накосячил ли', () {
    expect(firstBloc?.state, InfoManyInit());
  });
}
