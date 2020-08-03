import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jalshakti/classes/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:jalshakti/classes/localization/localization.dart';
import 'package:jalshakti/screens/admin/survey_approval_help.dart';
import 'package:jalshakti/screens/admin/survey_details.dart';

class SurveyApprovalScreen extends StatefulWidget {
  @override
  _SurveyApprovalScreenState createState() => _SurveyApprovalScreenState();
}

class _SurveyApprovalScreenState extends State<SurveyApprovalScreen> {
  bool surveysAvailable = false;
  bool isLoading = true;

  var surveys;

  @override
  void initState() {
    getSurveyDetails();
    super.initState();
  }

  Future<void> getSurveyDetails() async {
    var prefs = await SharedPreferences.getInstance();
    var jsonResponse;
    var region = {
      "state": prefs.getString('state'),
      "district": prefs.getString('district')
    };
    try {
      var response = await http.post(SERVER_URL + '/api/getSurveys',
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
          body: jsonEncode(region));
      if (response.statusCode == 200) {
        //data has been received...
        jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 0) {
          print("Message:${jsonResponse['message']}");
          Timer(Duration(milliseconds: 2000), () {
            setState(() {
              isLoading = false;
              surveysAvailable = false;
            });
          });
        } else {
          print(jsonResponse['message']);
          surveys = jsonResponse['message'];
          setState(() {
            isLoading = false;
            surveysAvailable = true;
          });
        }
      } else {
        //some other error
        print('Some error here...');
        print(response.statusCode);
      }
    } on TimeoutException catch (e) {} on SocketException catch (e) {} on Error catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Approval"),
          actions: <Widget>[
            /*
            IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ApprovalHelp();
                  }));
                }),
                */
          ],
        ),
        body: RefreshIndicator(
            child: !surveysAvailable
                ? Column(
                    children: <Widget>[
                      !isLoading
                          ? Text("No surveys available...")
                          : Container(),
                      isLoading ? CircularProgressIndicator() : Container(),
                    ],
                  )
                : Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                              itemCount: surveys.length,
                              itemBuilder: (context, index) {
                                return SurveyDescriptionCard(
                                    surveys[index]["surveyer"],
                                    surveys[index]["time-stamp"],
                                    surveys[index]["survey-status"],
                                    surveys[index]["image-url"],
                                    surveys[index]["location"],
                                    surveys[index]["surveyId"]);
                              }),
                        )
                      ],
                    ),
                  ),
            onRefresh: () {
              isLoading = true;
              return getSurveyDetails();
            }));
  }
}

class SurveyDescriptionCard extends StatelessWidget {
  final String user, date, status, imageUrl, surveyId;
  final location;
  SurveyDescriptionCard(this.user, this.date, this.status, this.imageUrl,
      this.location, this.surveyId);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      height: 140,
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        shadowColor: this.status == "Pending"
            ? Colors.redAccent
            : Colors.lightGreenAccent,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                  width: 4,
                  color: status == "Pending" ? Colors.redAccent : Colors.green),
            ),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                    child: status == "Pending"
                        ? Icon(
                            Icons.error_outline,
                            color: Colors.orange,
                          )
                        : Icon(
                            Icons.done,
                            color: Colors.green,
                            semanticLabel: "Pending",
                          ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                    AppLocalizations.of(context).surveyerName + " : " + user),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                    AppLocalizations.of(context).surveyDate + " : " + date),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: status == "Pending"
                      ? GestureDetector(
                          onTap: () {
                            //go to survey details screen
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SurveyDetails(
                                  user: user,
                                  date: date,
                                  imageUrl: imageUrl,
                                  location: location,
                                  surveyId: surveyId);
                            }));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context).check,
                                style: TextStyle(color: Colors.grey),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).approved,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
