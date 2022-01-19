import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/common/consts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/infocurrent/bloc/infoCurrent.bloc.dart';
import 'package:weather/infocurrent/bloc/infoCurrent.event.dart';
import 'package:weather/infocurrent/bloc/infoCurrent.state.dart';

class InfoCurrentPage extends StatefulWidget {
  const InfoCurrentPage({Key? key, required this.cityName}) : super(key: key);
  final String cityName;

  @override
  _InfoPageCurrentState createState() => _InfoPageCurrentState();
}

class _InfoPageCurrentState extends State<InfoCurrentPage> {
  bool _initForward = false;
  @override
  void initState() {
    super.initState();
    context.read<InfoCurrentBloc>().add(EInfoCurrentLoading(widget.cityName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.cityName} ${_parseDate()}'),
          actions: _initForward
              ? [
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: IconButton(
                      tooltip: 'Next page',
                      onPressed: _onForward,
                      icon: const Icon(Icons.arrow_forward_sharp),
                    ),
                  )
                ]
              : null,
        ),
        body: Center(
            child: BlocListener<InfoCurrentBloc, InfoCurrentState>(
          listener: (context, state) {
            if (state is InfoCurrentError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  '${state.errorMsg}',
                  textAlign: TextAlign.center,
                ),
                duration: const Duration(seconds: 5),
              ));
              setState(() {
                _initForward = false;
              });
            } else {
              setState(() {
                _initForward = true;
              });
            }
          },
          child: BlocBuilder<InfoCurrentBloc, InfoCurrentState>(
            builder: (context, state) {
              if (state is InfoCurrentError) {
                return const Center(
                  child: Text('Ошибка получения данных'),
                );
              }
              if (state is InfoCurrentLoaded) {
                return ListView.builder(
                  itemCount: state.weather.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0,
                      child: ListTile(
                        title: Text(_parseTime(state.weather[index].datetime)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Temp: ${state.weather[index].temp}'),
                            Text('Humidity: ${state.weather[index].humidity}'),
                            Text(
                                'Wind Speed: ${state.weather[index].windSpeed}')
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )));
  }

  String _parseTime(DateTime value) {
    final format = DateFormat('HH:mm');
    return format.format(value);
  }

  String _parseDate() {
    final format = DateFormat('dd.MM');
    return format.format(DateTime.now());
  }

  void _onForward() {
    Navigator.of(context).pushNamed(infoManyPath, arguments: widget.cityName);
  }
}
