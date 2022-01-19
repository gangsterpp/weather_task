import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/common/app.routes.dart';
import 'package:weather/infocurrent/bloc/infoCurrent.bloc.dart';
import 'package:weather/infocurrent/bloc/infoCurrent.state.dart';
import 'package:weather/infomany/bloc/infoMany.bloc.dart';
import 'package:weather/infomany/bloc/infoMany.state.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InfoCurrentBloc(InfoCurrentInit()),
        ),
        BlocProvider(
          create: (context) => InfoManyBloc(InfoManyInit()),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
