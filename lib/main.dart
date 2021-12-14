import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/cubit/cubit.dart';
import 'package:weather/data/traverse.dart';
import 'package:weather/data/repository.dart';
import 'package:weather/pages/weather_page.dart';
import 'package:provider/provider.dart';

// void main() => runApp(MyApp());
void main() {
  runApp(ChangeNotifierProvider(create: (_) => TraverseIndexModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider(
        create: (context) => WeatherCubit(WeatherRepository()),
        child: WeatherPage(),
      ),
    );
  }
}