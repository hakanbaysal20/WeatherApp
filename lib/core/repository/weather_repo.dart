

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:weather_app/core/model/weather_model.dart';
import 'package:weather_app/core/model/weather_response.dart';

class WeatherRepository{

  List<WeatherModel> parseWeatherResponse(dynamic response){
      return WeatherResponse.fromJson(response).weather;
  }


  Future<List<WeatherModel>> getWeather() async{
    var baseUrl = "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=ankara";
    var response = await Dio().get(baseUrl,options: Options(headers: {"content-type": "application/json","authorization" : 'apikey 3oUEKEAb53O75ZKPsFQfwu:6SURV8X5pDf0iKBbT2NkhW'}));
    print(response.data);
    return parseWeatherResponse(response.data);

  }
  Future<List<WeatherModel>> getWeatherByCity(String city) async{
    var baseUrl = "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$city";
    var response = await Dio().get(baseUrl,options: Options(headers: {"content-type": "application/json","authorization" : "apikey 3oUEKEAb53O75ZKPsFQfwu:6SURV8X5pDf0iKBbT2NkhW"}));
    return parseWeatherResponse(response.data);
  }
}
