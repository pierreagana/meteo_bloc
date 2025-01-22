import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart' as intl;
import 'package:meteo_bloc/ui/main_scaffold.dart';

void main() {
  // Initialiser les données de la locale "fr_FR"
  initializeDateFormatting('fr_FR', null).then((_) {
    // Exemple de date
    DateTime dateTime = DateTime.now();
    // Formater la date pour obtenir le jour de la semaine en français
    String formattedDate = DateFormat('EEEE', 'fr_FR').format(dateTime);
    print(formattedDate);  // Affichera le jour de la semaine en français (ex: "lundi")
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const MainScaffold(),
    );
  }
}

