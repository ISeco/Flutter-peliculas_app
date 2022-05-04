import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:peliculas_app/screens/screens.dart';
import 'package:peliculas_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'package:peliculas_app/providers/movies_provider.dart'; 

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(AppState());
}

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false)
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'home',
      routes: {
        'home' : (_) => const HomeScreen(),
        'details' : (_) => const DetailsScreen()
      },
      theme: AppTheme.lightTheme,
    );
  }
}