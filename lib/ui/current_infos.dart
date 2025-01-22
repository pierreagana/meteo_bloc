import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meteo_bloc/model/weather.dart';

class CurrentInfos extends StatelessWidget {

  final Location? location;
  final Current? current;

  const CurrentInfos({super.key, required this.current, required this.location});

  @override
  Widget build(BuildContext context) {
    return (location == null || current == null)
        ? const SizedBox( height: 0,)
        : Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(location?.name ?? "",style:  Theme.of(context).textTheme.titleLarge,),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(location?.region ?? ""),
                Text(location?.country ?? ""),
              ],
            ),
            const Divider(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${current?.temperature ?? 0 }C"),
                if(current?.condition?.icon != null)
                  Image.network("https:${current!.condition!.icon}")
              ],
            ),
            Text(current?.condition?.text ?? ""),
            const SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                infos(Icons.cloud_outlined, "${current?.clouds ?? 0}%"),
                infos(Icons.water_drop_outlined, "${current?.precipitation ?? 0}mm"),
                infos(Icons.visibility_outlined, "${current?.visibility ?? 0}kms"),
                infos(Icons.wb_sunny_outlined, "UV: ${current?.uv ?? 0}"),
              ],
            ),
            const SizedBox(height: 16,),
            Text("Ressenti: ${current?.feelsLike}C"),
            Text("Humidité: ${current?.humidity}%"),
            const SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
  
  Column infos(IconData id, String value){
    return Column(
       children: [
         Icon(id),
         Text(value)
       ],
    );
  }

}