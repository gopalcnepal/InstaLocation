import 'package:InstaLocation/home_page.dart';
import 'package:flutter/material.dart';

const kHighScoreTableHeaders = TextStyle(
  color: Colors.black,
  fontSize: 30.0,
  fontWeight: FontWeight.w300,
  letterSpacing: 1.0,
);

const kHighScoreTableRowsStyle = TextStyle(
  color: Colors.black,
  fontSize: 15.0,
  fontWeight: FontWeight.w300,
  letterSpacing: 1.0,
);

class LocScreen extends StatelessWidget {
  final query;

  LocScreen({this.query});

  List<TableRow> createRow(var query) {
    List<TableRow> rows = [];
    rows.add(
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Center(
              child: Text(
                "Date",
                style: kHighScoreTableHeaders,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Center(
              child: Text(
                "Lat",
                style: kHighScoreTableHeaders,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Center(
              child: Text(
                "Lon",
                style: kHighScoreTableHeaders,
              ),
            ),
          ),
        ],
      ),
    );

    int numOfRows = query.length;
    for (var i = 0; i < numOfRows && i < 15; i++) {
      var row = query[i].toString().split(",");
      var locDate = row[0];
      var lat = row[1];
      var lon = row[2];
      //var scoreDate = date;

      Widget item = TableCell(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '$locDate',
              style: kHighScoreTableRowsStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
      Widget item1 = TableCell(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '$lat',
              style: kHighScoreTableRowsStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
      Widget item2 = TableCell(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Text(
            '$lon',
            style: kHighScoreTableRowsStyle,
            textAlign: TextAlign.left,
          ),
        ),
      );
      rows.add(
        TableRow(
          children: [item, item1, item2],
        ),
      );
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Location'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: query.length == 0
            ? Stack(
                children: <Widget>[
                  Center(
                    child: Text(
                      "No Location Yet!",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      textBaseline: TextBaseline.alphabetic,
                      children: createRow(query),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
