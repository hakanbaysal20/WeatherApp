
import 'package:weather_app/core/model/weather_model.dart';



class  WeatherResponse{
  List<WeatherModel> weather;
  WeatherResponse({required this.weather});

  factory WeatherResponse.fromJson(Map<String,dynamic> json){
    var jsonArray = json["result"] as List;
    var weather = jsonArray.map((jsonArrayNesnesi) => WeatherModel.fromJson(jsonArrayNesnesi)).toList();
    return WeatherResponse(weather: weather);
  }
}