class WeatherModel {
  final double tempC;
  final String? condition;
  final String name;
  final double? wind;
  final int? humidity;
  final int? cloud;
  final String localtime;

  WeatherModel({required this.tempC, this.condition,required this.name, this.wind, this.humidity, this.cloud,required this.localtime});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      name: json['location']['name'] ?? 'Unknown',
      tempC: (json['current']['temp_c'] ?? 0).toDouble(),
      wind: (json['current']['wind_kph'] ?? 0).toDouble(),
      humidity: (json['current']['humidity'] ?? 0).toInt(),
      cloud: (json['current']['cloud'] ?? 0).toInt(),
      localtime: json['location']['localtime'],
    );
  }
}