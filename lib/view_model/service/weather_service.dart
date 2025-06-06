import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class WeatherService {
  static const String _baseUrl = 'http://api.weatherapi.com/v1/current.json';
  static const String _apiKey = 'dd2bdb5aad2f43d1ae4121757251705';

      Future<WeatherModel> getWeather(String cityName) async {
        final Uri url = Uri.parse('$_baseUrl?key=$_apiKey&q=$cityName');

        final response = await http.get(url);

        if (response.statusCode == 200) {
          print(response.body);
          return WeatherModel.fromJson(jsonDecode(response.body,) as Map<String,dynamic>);


        }else {
          throw Exception('Failed to load the weather data');
        }
      }





}
