

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/model/weather_model.dart';
import 'package:weather_app/core/repository/weather_repo.dart';

class HomeCubit extends Cubit<List<WeatherModel>>{
  HomeCubit():super(<WeatherModel>[]);

  var kRepo = WeatherRepository();

  Future<void> getWeatherData() async{
    var list = await kRepo.getWeather();
    emit(list);
  }

}