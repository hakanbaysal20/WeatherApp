

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:weather_app/core/model/weather_model.dart';
import 'package:weather_app/core/model/weather_response.dart';
import 'package:weather_app/core/service/api_key.dart';

class WeatherRepository{

  List<WeatherModel> parseWeatherResponse(dynamic response){
      return WeatherResponse.fromJson(response).weather;
  }


  Future<List<WeatherModel>> getWeather() async{
    var baseUrl = "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=ankara";
    var response = await Dio().get(baseUrl,options: Options(headers: {"content-type": "application/json","authorization" : ApiKey.API_KEY}));
    print(response.data);
    return parseWeatherResponse(response.data);

  }
  Future<List<WeatherModel>> getWeatherByCity(String city) async{
    var baseUrl = "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$city";
    var response = await Dio().get(baseUrl,options: Options(headers: {"content-type": "application/json","authorization" : ApiKey.API_KEY}));
    return parseWeatherResponse(response.data);
  }
}
