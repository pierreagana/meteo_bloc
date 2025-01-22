import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:meteo_bloc/bloc/bloc.dart';
import 'package:meteo_bloc/model/weather.dart';
import 'package:meteo_bloc/services/api_service.dart';

class BlocWeather extends Bloc {

  final StreamController<Weather> _weatherstreamController = StreamController<Weather>();
  Sink<Weather> get sink => _weatherstreamController.sink;
  Stream<Weather> get stream => _weatherstreamController.stream;

  @override
  dispose() {
    // TODO: implement dispose
    throw UnimplementedError();
  }

  getWeather (Position position) async {
    final Weather weather = await ApiService(position: position).callAPI();
    sink.add(weather);
  }

}