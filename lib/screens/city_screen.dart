import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 30.0,
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 20, left: 15, right: 20),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    icon: Icon(
                      Icons.location_city,
                    ),
                    hintText: 'Enter City Name',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                color: Colors.lightBlue,
                child: Text(
                  'Get Weather',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
