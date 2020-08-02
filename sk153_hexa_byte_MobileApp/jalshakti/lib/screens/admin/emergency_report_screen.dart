import 'package:flutter/material.dart';
import 'package:jalshakti/classes/Constants.dart';
import 'package:jalshakti/screens/admin/emergency_report_details.dart';

class EmergencyReport extends StatelessWidget {
  static const String EMERGENCY =
      "A situation where rapid deterioration of the embankment is occuring. Such a situation that may possibly cause damage to life and property\n\nIf you recognize the current situation of the embankment to be fatal, please report an emergency.";
  static const String WARNING =
      "A situation where any occuring event or circumstance could potentially adversely affect the integrity of the embankment but is considered controllable";
  static const String ADVISE =
      "A situation where an unusual problem or situation has occured, but failure of embankment is not imminent";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              //background container
              Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff14235e),
                      Color(0xffc68ebd),
                      Color(0xffffd3be)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              //appBar
              _buildAppBar(context),
              _buildMainContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          Expanded(
            flex: 8,
            child: Text(
              "Report",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //emergency card
          _buildEmergencyCard(context),
          //warning card
          _buildWarningCard(context),
          //advisory card
          _buildAdvisoryCard(context),
        ],
      ),
    );
  }
}

Widget _buildEmergencyCard(BuildContext context) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        width: 5,
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Embankment Emergency",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ReportDetails(reportType: "EE");
                    }));
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(EmergencyReport.EMERGENCY),
          ),
        ],
      ),
    ),
  );
}

Widget _buildWarningCard(BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(
      side: BorderSide(
        width: 5,
        color: Colors.yellow,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Embankment Warning",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: myYellow,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ReportDetails(reportType: "EW");
                    }));
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(EmergencyReport.WARNING),
          ),
        ],
      ),
    ),
  );
}

Widget _buildAdvisoryCard(BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(
      side: BorderSide(
        width: 5,
        color: Colors.blue,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Embankment Advisory",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ReportDetails(reportType: "EA");
                    }));
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(EmergencyReport.ADVISE),
          ),
        ],
      ),
    ),
  );
}
