import 'package:InstaLocation/loc_screen.dart';
import 'package:InstaLocation/models/user_loc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'utilities/user_loc_db.dart' as user_loc_db;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position _currentPosition;
  // Storing Location
  final database = user_loc_db.openDB();

  void queryScores() async {
    final database = user_loc_db.openDB();
    var queryResult = await user_loc_db.locations(database);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocScreen(query: queryResult);
        },
      ),
    );
  }

  void storeLocation() {
    UserLocation location = UserLocation(
        id: 1,
        locDateTime: DateTime.now().toString(),
        userLat: _currentPosition.latitude,
        userLon: _currentPosition.longitude);
    user_loc_db.manipulateDatabase(location, database);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InstaLocation"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_currentPosition != null)
                Text(
                    "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
              FlatButton(
                child: Text("Get location"),
                onPressed: () {
                  _getCurrentLocation();
                },
              ),
              FlatButton(
                child: Text("Show location"),
                onPressed: () {
                  queryScores();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getCurrentLocation() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;

        storeLocation();
      });
    }).catchError((e) {
      print(e);
    });
  }
}
