import 'package:flutter/material.dart';

class ForecastWidget extends StatefulWidget {
  @override
  _ForecastWidgetState createState() => _ForecastWidgetState();
}

class _ForecastWidgetState extends State<ForecastWidget> {
  List<Forecast> forecasts = [];

  @override
  void initState() {
    super.initState();
    fetchForecasts();
  }

  Future<void> fetchForecasts() async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    var fetchedForecasts = [
      // Example data that might come from an API
      {'time': '18:00', 'aqi': '50', 'temperature': '20°C'},
      {'time': '22:00', 'aqi': '60', 'temperature': '18°C'},
      {'time': '22:00', 'aqi': '60', 'temperature': '18°C'},
      {'time': '22:00', 'aqi': '60', 'temperature': '18°C'},
      {'time': '22:00', 'aqi': '60', 'temperature': '18°C'},


      // Add more entries as needed
    ].map((json) => Forecast.fromJson(json)).toList();

    setState(() {
      forecasts = fetchedForecasts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343, // Fill width
      height: 240, // Hug height
      padding: EdgeInsets.fromLTRB(16, 16, 8, 18), // Padding
      margin: EdgeInsets.symmetric(vertical: 16), // Gap
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        color: Colors.white.withOpacity(0.5), // Placeholder color
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecasts.length,
        itemBuilder: (context, index) {
          final forecast = forecasts[index];
          return Container(
            width: 50,
            height:146,

            margin: EdgeInsets.all(7),
            decoration: BoxDecoration(

              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 32,
                  height: 8,
                  child: Opacity(
                    opacity: 0,
                      child: Text("")

                  ),
                ),
                SizedBox(height: 10),
                Text(
                  forecast.time, // Time
                  style: TextStyle(
                    fontFamily: "SF Pro Display",
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    height: 8 / 8,
                    color: Colors.grey.shade800,

                  ),

                  textAlign: TextAlign.center,

                ),
                SizedBox(height: 10),// Gap
                Text(
                  "- aqi", // Text
                  style: TextStyle(
                    fontFamily: "SF Pro Display",
                    fontSize: 8,
                    fontWeight: FontWeight.w300,
                    height: 9.55 / 8,
                    color: Colors.grey.shade800,
                  ),
                  textAlign: TextAlign.right, // Text align
                ),
                SizedBox(height: 10), // Gap

                SizedBox(height: 10),
                Icon(Icons.cloud, size: 24),
                SizedBox(height: 10),
                Text(forecast.aqi),
                Text(forecast.temperature),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Forecast {
  final String time;
  final String aqi;
  final String temperature;

  Forecast({required this.time, required this.aqi, required this.temperature});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      time: json['time'],
      aqi: json['aqi'].toString(),
      temperature: json['temperature'].toString(),
    );
  }
}
