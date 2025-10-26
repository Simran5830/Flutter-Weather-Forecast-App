import 'package:http/http.dart' as http;
import 'package:flutter_weather/model/weather_model.dart';
import 'dart:convert';

class  WeatherApi {
  
static Future <WeatherModel?> fetchData(String city) async{
    try{
    String api_key= "1a2ce4b4199265b36a5d0b6f10cb5a01";
    // String city=controller.text;
    final url="https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${api_key}&units=metric";

    final uri=Uri.parse(url);
    final response= await http.get(uri);
    final output= jsonDecode(response.body);
    print("fetch pressed");
    return WeatherModel.fromJson(output);
    // setState(() {
    //   temp=output['main']['temp'].toString();
    // });
    
    }catch(e){
      print(e);
      return null;
    }
    }
}