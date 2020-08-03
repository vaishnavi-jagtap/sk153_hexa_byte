import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:jalshakti/classes/Constants.dart';
import 'package:jalshakti/classes/localization/localization.dart';
import 'package:jalshakti/screens/fullscreen_image.dart';

class SurveyDetails extends StatefulWidget {
  final String user, date, surveyId;
  var url = "";

  final imageUrl;
  final location;

  SurveyDetails(
      {this.user, this.date, this.imageUrl, this.location, this.surveyId});

  @override
  _SurveyDetailsState createState() => _SurveyDetailsState();
}

class _SurveyDetailsState extends State<SurveyDetails> {
  bool isApproving = false;

  Future<bool> approveSurvey(surveyId) async {
    var prefs = await SharedPreferences.getInstance();
    String state = prefs.getString("state");
    String district = prefs.getString("district");
    print("District from surveydetails........$district");
    var flag = false;
    setState(() {
      isApproving = true;
    });
    try {
      var response = await http.post(SERVER_URL + '/api/survey/approve',
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
          body: jsonEncode(
              {"surveyId": surveyId, "state": state, "district": district}));

      if (response.statusCode == 200) {
        print("Done.......Data sent for approval.......");
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        if (jsonResponse['status'] == "OK") {
          flag = true;
        }
      } else {
        print(response.statusCode);
      }
    } on TimeoutException catch (e) {
      print("Timeout exception...");
    } on SocketException catch (e) {
      print("Socket exception...");
    } on Exception catch (e) {
      print("Some error occurred....");
    }
    setState(() {
      isApproving = false;
    });
    return flag;
  }

  _showConfirmationDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you sure?"),
            content:
                Text("This data will be stored into database as valid data"),
            actions: <Widget>[
              // FlatButton(
              //   onPressed: () {
              //     //discard the survey data and remove it from database
              //     Navigator.pop(context);
              //     Navigator.pop(context);
              //   },
              //   child: Text("No"),
              // ),
              isApproving
                  ? CircularProgressIndicator()
                  : FlatButton(
                      onPressed: () async {
                        //update status of survey as approved in the database

                        print(widget.surveyId);

                        var approved = await approveSurvey(widget.surveyId);
                        print(approved);

                        if (approved) {
                          print("Survey Approved....!");
                          Navigator.pop(context);
                        }
                        Navigator.pop(context);
                      },
                      child: Text("Yes"),
                    ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //Widget to display user details

    widget.url = SERVER_URL + "/" + widget.imageUrl;

    final surveyDetailsHeader = Container(
      height: 100,
      width: double.maxFinite,
      child: Container(
        child: Card(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(width: 4, color: Colors.blue),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 10, left: 20),
                  child: Text(AppLocalizations.of(context).surveyer +
                      " : " +
                      widget.user),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10, left: 20),
                  child: Text(AppLocalizations.of(context).surveyDate +
                      " : " +
                      widget.date),
                ),
              ],
            ),
          ),
        ),
      ),
    );

//Widget to hold surveyed image
    final surveyImage = Container(
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
              child: GestureDetector(
                onTap: () {
                  debugPrint("Image:${SERVER_URL + widget.imageUrl}");

                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return FullScreenImage(imageUrl: widget.url);
                  }));
                },
                child: Hero(
                  tag: "fullImage",
                  child: Image.network(
                    widget.url,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final imageLocationDetails = Container(
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 4, color: Colors.blue),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 5,
                        ),
                        child: Text(AppLocalizations.of(context).imageLocation),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 5,
                          bottom: 10,
                        ),
                        child: Text(
                          "${widget.location['latitude']},${widget.location['longitude']}",
                          style: TextStyle(color: Colors.lightBlueAccent),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: RaisedButton(
                    child: Text(AppLocalizations.of(context).seeOnMap),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(width: 2, color: Colors.blue),
                    ),
                    onPressed: () async {
                      final String googleMapsUrl =
                          "https://www.google.com/maps/search/?api=1&query=${widget.location['latitude']},${widget.location['longitude']}";

                      final String appleMapsUrl =
                          "https://maps.apple.com/?q=${widget.location['latitude']},${widget.location['longitude']}";

                      if (Platform.isAndroid) {
                        if (await canLaunch(googleMapsUrl)) {
                          await launch(googleMapsUrl);
                        }
                      }
                      if (Platform.isIOS) {
                        if (await canLaunch(appleMapsUrl)) {
                          await launch(appleMapsUrl, forceSafariVC: false);
                        }
                      } else {
                        debugPrint("Couldn't launch URL on IOS");
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final approvalWarning = Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.orangeAccent,
            ),
            Expanded(
              child: Text(
                AppLocalizations.of(context).surveyApprovalWarning,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );

    final approvalSection = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: RaisedButton(
            child: Text(AppLocalizations.of(context).deny),
            color: Colors.white,
            elevation: 5,
            onPressed: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: Text(
              AppLocalizations.of(context).approve,
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            elevation: 5,
            onPressed: () {
              //approve the survey and update its status in database
              _showConfirmationDialogBox(context);
            },
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Survey Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            surveyDetailsHeader,
            surveyImage,
            imageLocationDetails,
            approvalWarning,
            approvalSection,
          ],
        ),
      ),
    );
  }
}
