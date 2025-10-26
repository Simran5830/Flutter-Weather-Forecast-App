class WeatherModel {
final double temp;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String description;
  final String main;
  final String city;
  final String country;
  final String icon;


  WeatherModel({
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.main,
    required this.city,
    required this.country,
    required this.icon,
  });

factory WeatherModel.fromJson(Map<String,dynamic> json){
  return WeatherModel(
   temp: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      description: json['weather'][0]['description'],
      main: json['weather'][0]['main'],
      city: json['name'],
      country: json['sys']['country'],
      icon: json['weather'][0]['icon'],
    );

}
}
