class WeatherModel{
  final date;
  final day;
  final icon;
  final description;
  final status;
  final degree;
  final min;
  final max;
  final night;
  final humidity;

  WeatherModel(
      {required this.date,
        required this.day,
        required this.icon,
        required this.description,
        required this.status,
        required this.degree,
        required this.min,
        required this.max,
        required this.night,
        required this.humidity});

  factory WeatherModel.fromJson(Map<String,dynamic> json){
    return WeatherModel(
        date: json["date"],
        day: json["day"],
        icon: json["icon"],
        description: json["description"],
        status: json["status"],
        degree: json["degree"],
        min: json["min"],
        max: json["max"],
        night: json["night"],
        humidity: json["humidity"]);
  }
}