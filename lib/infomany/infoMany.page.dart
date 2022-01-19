import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/infomany/bloc/infoMany.bloc.dart';
import 'package:weather/infomany/bloc/infoMany.event.dart';
import 'package:weather/infomany/bloc/infoMany.state.dart';

class InfoManyPage extends StatefulWidget {
  const InfoManyPage({Key? key, required this.cityName}) : super(key: key);
  final String cityName;

  @override
  _InfoPageManyState createState() => _InfoPageManyState();
}

class _InfoPageManyState extends State<InfoManyPage> {
  @override
  void initState() {
    super.initState();
    context.read<InfoManyBloc>().add(EInfoManyLoading(widget.cityName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.cityName),
        ),
        body: BlocBuilder<InfoManyBloc, InfoManyState>(
          builder: (context, state) {
            if (state is InfoManyError) {
              return Center(
                child: Text('${state.errorMsg}'),
              );
            } else if (state is InfoManyLoaded) {
              return ListView.builder(
                itemCount: state.weather.length,
                itemBuilder: (context, index1) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: ListTile(
                          title: Text(
                              _parseDate(state.weather[index1][0].datetime)),
                          subtitle: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.weather[index1].length,
                            itemBuilder: (context, index2) {
                              return Card(
                                  child: SizedBox(
                                      width: 150,
                                      height: 100,
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.all(2),
                                        title: Text(_parseTime(state
                                            .weather[index1][index2].datetime)),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Temp: ${state.weather[index1][index2].temp}'),
                                            Text(
                                                'Wind Speed: ${state.weather[index1][index2].windSpeed}'),
                                            Text(
                                                'Humidity: ${state.weather[index1][index2].humidity}')
                                          ],
                                        ),
                                      )));
                            },
                          ),
                        )),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  String _parseDate(DateTime value) {
    final format = DateFormat('dd.MM');
    return format.format(value);
  }

  String _parseTime(DateTime value) {
    final format = DateFormat('HH:mm');
    return format.format(value);
  }
}
