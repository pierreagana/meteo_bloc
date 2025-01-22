import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:meteo_bloc/bloc/bloc_provider.dart';
import 'package:meteo_bloc/bloc/bloc_weather.dart';
import 'package:meteo_bloc/model/weather.dart';
import 'package:meteo_bloc/ui/current_infos.dart';

class WeatherWdget extends StatelessWidget {
  final Position position;

  const WeatherWdget({super.key, required this.position});
  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<BlocWeather>(context);

    bloc?.getWeather(position);

    return StreamBuilder<Weather>(
        stream: bloc?.stream,
        builder: (context, snapshot) {
          return (!snapshot.hasData)
              ? const Text("Rien pour le moment")
              : Column(
            children: [
              CurrentInfos(
                  current: snapshot.data?.current,
                  location: snapshot.data?.location
              ),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: ((context, index) {
                        final day = snapshot.data?.forecast?.forecastDay[index];
                        if(day == null) return const SizedBox(height: 0,);
                        return ExpansionTile(
                            title: Row(
                              children: [
                                if(day.day?.condition?.icon!= null) Image.network("https:${day!.day!.condition!.icon}"),
                                const Spacer(),
                                Text(readableDate(day.date)),

                              ],
                            ),
                          subtitle: Row(
                            children: [
                              Text(day.day?.condition?.text ?? ""),
                              const Spacer(),
                              const Icon(Icons.arrow_drop_down_sharp),
                              Text("${day.day?.minTemp ?? 0}C"),
                              const Icon(Icons.arrow_drop_up_sharp),
                              Text("${day.day?.maxTemp ?? 0}C"),
                            ],
                          ),
                          children: [
                            Text("Vent: ${day.day?.wind ?? 0} km/h"),
                            Text("Pluie: ${day.day?.precipitation ?? 0}mm - ${day.day?.chanceRain ?? 0}%"),
                            //Text("Neige: ${day.day?.snow ?? 0}mm - ${day.day?.chanceSnow ?? 0}%"),
                            Text("Visibilité: ${day.day?.visibility}kms"),
                            Text("Indice UV: ${day.day?.uv ?? 0}"),
                            Text("Humidité: ${day.day?.humidity ?? 0}%"),
                          ],
                        );
                      }),
                      separatorBuilder: ((ctv, i) => const Divider()),
                      itemCount: snapshot.data?.forecast?.forecastDay.length ?? 0
                  )
              )
            ],
          );
        }
    );
  }
 String readableDate(String? data){
    if(data == null) return "";
    final DateTime dateTime = DateTime.parse(data);

    return DateFormat('EEEE', 'fr_FR').format(dateTime);
 }
}