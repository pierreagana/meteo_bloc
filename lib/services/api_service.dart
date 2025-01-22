import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../model/weather.dart';

class ApiService {

  final Position position;

  const ApiService({required this.position});

  //requete url
  Uri urlRequest(){
    const apiKEY = "b6ea6a23f2024b42bb9234237252101";
    const baseURL = "https://api.weatherapi.com/v1/forecast.json";
    const days = "7";
    const lang = "fr";
    String q = "${position.latitude}, ${position.longitude}";

    String urlString = "$baseURL?key=$apiKEY&q=$q&lang=$lang&days=$days";

        return Uri.parse(urlString);
  }

// appelle de api
  Future<Weather> callAPI() async {
    final result = await http.get(urlRequest());
    final body = json.decode(utf8.decode(result.bodyBytes));
    return Weather.fromJson(body);
  }

}