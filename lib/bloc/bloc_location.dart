import 'package:flutter/material.dart';
import 'package:meteo_bloc/bloc/bloc.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class BlocLocation extends Bloc {

  BlocLocation() {
    getCurrentPosition();
}

  final StreamController<Position> _positionController = StreamController<Position>();

  Sink<Position> get sink => _positionController.sink;
  Stream<Position> get stream => _positionController.stream;

  //Autorisation de lutilisateur
  Future<bool> _locationPermission() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnable) return false;
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if(permission == LocationPermission.denied) return false;
    }
    if(permission == LocationPermission.deniedForever) return false;
    return true;
  }

  //Recuperer la position
  getCurrentPosition() async {
    final hasPermission = await _locationPermission();
    if(!hasPermission) return ;
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    ).then((Position position){
      sink.add(position);
    }).catchError((e){
      debugPrint(e);
    });
  }


  @override
  dispose() => _positionController.close();

}