
import '../../core/model/weather_model.dart';

abstract class WeatherState{
 const WeatherState();


}

class WeatherInitial extends WeatherState{
  const WeatherInitial();
}

class WeatherLoading extends WeatherState{
  const WeatherLoading();
}
class WeatherCompleted extends WeatherState{
  final List<WeatherModel> response;
  final String city;

  const WeatherCompleted(this.response, this.city);
}


class WeatherError extends WeatherState{
  final String message;
  const WeatherError(this.message);
}