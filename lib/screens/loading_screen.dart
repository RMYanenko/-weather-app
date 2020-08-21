import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const appKey = '1513ad5284e73805a5e244ce08c6e71c';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  getLocationData() async {
    Location location = Location();

    await location.getCurrentLocation();

    // latitude = location.latitude;
    // longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
      url:
          'https://samples.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$appKey',
    );

    var weatherData = await networkHelper.getData();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(locationWeather: weatherData,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.blueGrey,
          size: 150.0,
        ),
      ),
    );
  }
}
