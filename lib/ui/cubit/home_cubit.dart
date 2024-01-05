

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/model/weather_model.dart';
import 'package:weather_app/core/repository/weather_repo.dart';
import 'package:weather_app/ui/cubit/weather_state.dart';

class HomeCubit extends Cubit<WeatherState>{
  HomeCubit():super(WeatherInitial());

  var kRepo = WeatherRepository();

  Future<void> getWeatherData() async{
    try{
      emit(WeatherLoading());
      Future.delayed(Duration(milliseconds: 500));
      var list = await kRepo.getWeather();
      emit(WeatherCompleted(list));
    }catch(e){
      emit(WeatherError("Couldn't fetch responses."));
    }
  }
  Future<void> getWeatherDataByCity(String city) async{
    try{
      emit(WeatherLoading());
      Future.delayed(Duration(milliseconds: 500));
      var list = await kRepo.getWeatherByCity(city);
      emit(WeatherCompleted(list));
    }catch(e){
      emit(WeatherError("Couldn't fetch responses."));
    }
  }
}