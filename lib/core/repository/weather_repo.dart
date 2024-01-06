

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:weather_app/core/model/weather_model.dart';
import 'package:weather_app/core/model/weather_response.dart';
import 'package:weather_app/core/service/api_key.g.dart';

abstract class WeatherRepository{

  Future<List<WeatherModel>> getWeather();
  Future<List<WeatherModel>> getWeatherByCity(String city);

}
class SampleWeatherRepository implements WeatherRepository{

  List<WeatherModel> parseWeatherResponse(dynamic response){
      return WeatherResponse.fromJson(response).weather;
  }


  @override
  Future<List<WeatherModel>> getWeather() async{
    var baseUrl = "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=ankara";
    var response = await Dio().get(baseUrl,options: Options(headers: {"content-type": "application/json","authorization" : ApiKey.API_KEY}));
    switch(response.statusCode){
      case HttpStatus.ok:

        return parseWeatherResponse(response.data);
      default:
        throw NetworkError(response.statusCode.toString(),response.data.toString());
    }

  }
  @override
  Future<List<WeatherModel>> getWeatherByCity(String city) async{
    var baseUrl = "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$city";
    var response = await Dio().get(baseUrl,options: Options(headers: {"content-type": "application/json","authorization" : ApiKey.API_KEY}));
    return parseWeatherResponse(response.data);
  }
}

class NetworkError implements Exception{
  final String statusCode;
  final String message;

  NetworkError(this.statusCode,this.message);
}
