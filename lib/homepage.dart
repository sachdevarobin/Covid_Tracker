import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Covid_Tracker/data.dart';
import 'package:Covid_Tracker/pages/countrydata.dart';
import 'package:Covid_Tracker/panels/effectedcountries.dart';
import 'package:Covid_Tracker/panels/worldwide.dart';
import 'package:http/http.dart' as http;
import 'package:Covid_Tracker/panels/info.dart';
import 'package:pie_chart/pie_chart.dart';
// import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
    print('fetch data called');
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "COVID-19 TRACKER",
            // style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.teal[800],
        ),
        body: RefreshIndicator(
          onRefresh: fetchData,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 100,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                color: Colors.teal[300],
                child: Text(
                  DataSource.quote,
                  style: TextStyle(
                    color: Colors.teal[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "World-Meter",
                        style: TextStyle(
                          color: Colors.teal[900],
                          fontWeight: FontWeight.w800,
                          fontSize: 26,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountryPage()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Countries >>",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  )),
              worldData == null
                  ? CircularProgressIndicator()
                  : WorldWidePan(
                      worldData: worldData,
                    ),
              PieChart(
                dataMap: {
                  'Cases': worldData['cases'].toDouble(),
                  'Active': worldData['active'].toDouble(),
                  'Recovered': worldData['recovered'].toDouble(),
                  'Deaths': worldData['deaths'].toDouble(),
                },
                colorList: [
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.grey[900]
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Most Affected Countries',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              countryData == null
                  ? Container()
                  : MostAffectedPanel(
                      countryData: countryData,
                    ),
              SizedBox(
                height: 20,
              ),
              InfoPan(),
              SizedBox(
                height: 20,
              ),
              Text(
                "Be happy, or at least Zen",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.pink),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
