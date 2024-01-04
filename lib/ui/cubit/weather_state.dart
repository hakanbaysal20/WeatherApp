
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

  const WeatherCompleted(this.response);
}

class WeatherError extends WeatherState{
  final String message;
  const WeatherError(this.message);
}