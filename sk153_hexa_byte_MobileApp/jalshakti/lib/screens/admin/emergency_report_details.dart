import 'package:flutter/material.dart';
import 'package:jalshakti/classes/Constants.dart';
import 'package:jalshakti/custom-widgets/emergencyAlert/ea_details.dart';
import 'package:jalshakti/custom-widgets/emergencyAlert/ee_details.dart';
import 'package:jalshakti/custom-widgets/emergencyAlert/ew_details.dart';

class ReportDetails extends StatefulWidget {
  final String reportType;

  ReportDetails({@required this.reportType});

  @override
  _ReportDetailsState createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  String state = "";
  String district = "";
  String region = "";

  onStateInput(String value) {
    print(value);
    this.state = value;
  }

  onDistrictInput(String value) {
    print(value);
    this.district = value;
  }

  onRegionInput(String value) {
    print(value);
    this.region = value;
  }

  getRegionData() {
    return {
      "state": this.state,
      "district": this.district,
      "region": this.region,
    };
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Emergency Report"),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              //background container
              Container(
                height: size.height * 2.15,
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

              Container(
                margin: EdgeInsets.only(top: 40),
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    _buildStateInputBox(),
                    _buildDistrictInputBox(),
                    _buildRegionInputBox(),
                    widget.reportType == "EE"
                        ? EEContent(getRegionData)
                        : widget.reportType == "EW"
                            ? EWContent(getRegionData)
                            : EAContent(getRegionData),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStateInputBox() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextField(
        onChanged: onStateInput,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: "State",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDistrictInputBox() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextField(
        onChanged: onDistrictInput,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: "District",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildRegionInputBox() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextField(
        onChanged: onRegionInput,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: "City / Town / Village",
          border: InputBorder.none,
        ),
      ),
    );
  }
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
            "Report Details",
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
//}
