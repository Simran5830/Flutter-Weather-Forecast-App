// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter_weather/weather_api.dart';
import 'package:flutter_weather/model/weather_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    loadCities();
  }
  List <String> cities=[];

  Future <void> loadCities() async{
     final String response= await rootBundle.loadString('assets/cities.json');
     final List<dynamic> data= jsonDecode(response);
     setState(() {
       cities=data.cast<String>();
     });
  }

  @override
void dispose() {
  controller.dispose();
  super.dispose();
}
  String temp="";
  bool isloading=false;
  TextEditingController controller=TextEditingController();
  WeatherModel? weather;

  Future<void> fetch()async{
    if (controller.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please enter a city name")),
    );
      return;
    }
    
      setState(() {
        isloading=true;
      });
     try {
    final result= await WeatherApi.fetchData(controller.text);
    setState(() {
      weather=result;
      isloading=false;
    });}catch(e){
      print('Error fetching weather: $e');
      setState(() {
        weather=null;
        isloading=false;
      });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("City not found or network error"),
      backgroundColor: Colors.red,)
    );
    }
    }

Color getBackgroundColor() {
  if (weather == null) return Colors.blueGrey; // default
  switch (weather!.description.toLowerCase()) {
    case 'clear sky':
      return Colors.orangeAccent;
    case 'few clouds':
    case 'scattered clouds':
    case 'broken clouds':
      return Colors.blueGrey;
    case 'shower rain':
    case 'rain':
      return Colors.indigo;
    case 'thunderstorm':
      return Colors.deepPurple;
    case 'snow':
      return Colors.lightBlueAccent;
    case 'mist':
      return Colors.grey;
    default:
      return Colors.blueGrey;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("weather"),),
      body:
      Padding(padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
          Expanded(child: 
          Autocomplete<String>
          (optionsBuilder: (textEditingValue) {
            if (textEditingValue.text.isEmpty){
              return Iterable<String>.empty();
            }
            return cities.where((city){
               return city.toLowerCase().contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (selectedCity) {
            setState(() {
              controller.text=selectedCity;
            });
          },
          
          
          )
          // TextField(
          //   controller:controller,
          //   decoration: InputDecoration(
          //   hintText: "eg-Delhi, Jaipur",
          //   labelText: "Enter city"),)
           ),
        ElevatedButton(onPressed: fetch,
         child: Icon(Icons.search)),
      ]),
      // SizedBox(height: 200),
       Expanded(      
          child: RefreshIndicator(
            onRefresh: fetch,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    if (isloading) CircularProgressIndicator(),
                  if(weather!=null)...[
                      // Text(weather!.temperature.toString()),
              
                  Card(
                    color: getBackgroundColor(),
                    elevation: 5,
                    shadowColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child:Padding(padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${weather!.description}"),
                      Text("Temperature: ${weather!.temp}°C"),
                      Text("Feels like: ${weather!.feelsLike}°C"),
                      Text("Humidity: ${weather!.humidity}%"),
                      Text("Wind Speed: ${weather!.windSpeed} m/s"),
                      Image.network('http://openweathermap.org/img/wn/${weather!.icon}@2x.png',  
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.error),),
                    ],
                  ),
                  )
                  )
                  ],],
                ),
              ),
            ),
          ),
        )
      ]
      ),
      ),
    );
  }}