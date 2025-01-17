import 'package:flutter/material.dart';

class WorldWidePan extends StatelessWidget {
  final Map worldData;

  const WorldWidePan({Key key, this.worldData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        children: <Widget>[
          StatusPanel(
            title: "CASES",
            panelColor: Colors.red[100],
            textColor: Colors.white,
            count: worldData['cases'].toString(),
          ),
          StatusPanel(
            title: "DEATHS",
            panelColor: Colors.red[100],
            textColor: Colors.white,
            count: worldData['deaths'].toString(),
          ),
          StatusPanel(
            title: "RECOVERED",
            panelColor: Colors.red[100],
            textColor: Colors.white,
            count: worldData['recovered'].toString(),
          ),
          StatusPanel(
            title: "ACTIVE",
            panelColor: Colors.red[100],
            textColor: Colors.white,
            count: worldData['active'].toString(),
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel(
      {Key key, this.panelColor, this.textColor, this.title, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(10),
      height: 80,
      width: width / 2,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
          ),
          Text(
            count,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          )
        ],
      ),
    );
  }
}
