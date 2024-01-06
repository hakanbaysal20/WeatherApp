

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/repository/weather_repo.dart';
import 'package:weather_app/ui/cubit/weather_state.dart';

class HomeCubit extends Cubit<WeatherState>{
  final WeatherRepository _weatherRepository;
  HomeCubit(this._weatherRepository):super(const WeatherInitial());

  Future<void> getWeatherData() async{
    try{
      emit(const WeatherLoading());
      Future.delayed(const Duration(milliseconds: 500));
      final list = await _weatherRepository.getWeather();
      emit(WeatherCompleted(list));
    } on NetworkError catch(e){
      emit(WeatherError(e.message));
    }
  }
  Future<void> getWeatherDataByCity(String city) async{
    try{
      emit(const WeatherLoading());
      Future.delayed(const Duration(milliseconds: 500));
      final list = await _weatherRepository.getWeatherByCity(city);
      emit(WeatherCompleted(list));
    } on NetworkError catch(e){
      emit(WeatherError(e.message));
    }
  }
}