

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/repository/weather_repo.dart';
import 'package:weather_app/ui/cubit/weather_state.dart';


class HomeCubit extends Cubit<WeatherState>{
  final WeatherRepository _weatherRepository;
  HomeCubit(this._weatherRepository):super(WeatherInitial());

  Future<String> getCityFromLocation() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission != LocationPermission.whileInUse && locationPermission != LocationPermission.always) {
        Geolocator.openAppSettings().then((value) async{
          locationPermission = await Geolocator.checkPermission();
        });
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemark = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    return placemark.first.administrativeArea.toString();
  }

  Future<void> getWeather() async{
    try{
      emit(WeatherInitial());
      final city = await getCityFromLocation();
      emit(WeatherLoading());
      final list = await _weatherRepository.getWeather(city);
      Future.delayed(const Duration(milliseconds: 1000));
      emit(WeatherCompleted(list,city));
    } on NetworkError catch(e){
      emit(WeatherError(e.message));
    }
  }

  Future<void> getWeatherByCity(String city) async{
    try{
      emit(WeatherInitial());
      emit(WeatherLoading());
      final list = await _weatherRepository.getWeatherByCity(city);
      Future.delayed(const Duration(milliseconds: 1000));
      emit(WeatherCompleted(list,city));
    } on NetworkError catch(e){
      emit(WeatherError(e.message));
    }
  }
}