import 'package:bloc/bloc.dart';
import 'package:weather/data/geo_location.dart';
import 'package:weather/data/model/weather_model.dart';
import 'package:weather/data/repository.dart';
import 'package:meta/meta.dart';

part 'state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final Repository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(WeatherInitial());

  Future<void> getWeather() async {
    try {
      emit(WeatherLoading());
      String latLng = await determinePosition();
      final weather = await _weatherRepository.fetchWeather(latLng);
      emit(WeatherLoaded(weather));
    } on NetworkException {
      emit(WeatherError("could not fetch data"));
    }
  }
}