import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather/cubit/cubit.dart';
import 'package:weather/data/model/weather_model.dart';
import 'package:weather/data/traverse.dart';

class WeatherPage extends StatelessWidget {
  void incrementIndex(BuildContext context, int max) {
    var _provider = Provider.of<TraverseIndexModel>(context, listen: false);
    _provider.incrementIndex(max);
  }

  void deIncrementIndex(BuildContext context) {
    var _provider = Provider.of<TraverseIndexModel>(context, listen: false);
    _provider.deIncrementIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Search"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial) {
              final weatherCubit = context.read<WeatherCubit>();
              weatherCubit.getWeather();
              return buildInitialInput(context);
            } else if (state is WeatherLoading) {
              return buildLoading();
            } else if (state is WeatherLoaded) {
              return buildColumnWithData(context, state.weather);
            } else {
              // (state is WeatherError)
              return buildInitialInput(context);
            }
          },
        ),
      ),
    );
  }

  Widget buildInitialInput(BuildContext context) {
    return Center(
      child: Container(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(BuildContext context, Weather weather) {
    Dataseries data = weather.dataseries[context.watch<TraverseIndexModel>().index];
    return Column(
      children: <Widget>[
        Text(
          weather.product,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        weatherDetail(context, "Cloud Cover", "${data.getCloudCover()}"),
        weatherDetail(context, "Visibility", "${data.getSeeing()}"),
        weatherDetail(context, "Transparency", "${data.getTransparency()}"),
        weatherDetail(context, "Lifted Index", "${data.getLiftedIndex()}"),
        weatherDetail(context, "Temperature", "${data.temp2m}"),
        weatherDetail(context, "Humidity", "${data.getHumidity()}"),
        weatherDetail(context, "Wind Direction", "${data.wind10m.direction}"),
        weatherDetail(context, "Wind Speed", "${data.getWindSpeed()}"),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Visibility(
              visible: context.watch<TraverseIndexModel>().index > 0,
              child: TextButton(
                  child: Text("prev"),
                  onPressed: () {
                    deIncrementIndex(context);
                  }),
            ),
            Visibility(
              visible: context.watch<TraverseIndexModel>().index < weather.dataseries.length - 1,
              child: TextButton(
                  child: Text("next"),
                  onPressed: () {
                    incrementIndex(context, weather.dataseries.length - 1);
                  }),
            ),
          ],
        )
        //buttonBuild(context)
      ],
    );
  }

  Widget weatherDetail(BuildContext context, String _title, String _itemValue) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        0,
        20,
        5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$_title",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "$_itemValue ",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  // Widget buttonBuild(BuildContext context, int max) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 50),
  //     child: TextButton(
  //         child: Text("next"),
  //         onPressed: () {
  //           Provider.of<TraverseIndexModel>(context, listen: false).incrementIndex(max);
  //         }),
  //   );
  // }
}
