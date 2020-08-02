import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:jalshakti/classes/Constants.dart';

//Emergency Class
class EEContent extends StatefulWidget {
  final getRegionData;
  EEContent(this.getRegionData);
  @override
  _EEContentState createState() => _EEContentState();
}

class _EEContentState extends State<EEContent> {
  TextEditingController msgController = TextEditingController();
  bool isVisible = false;
  SnackBar snackBar;

  var data = [
    {
      "id": 1,
      "title": "Seepage",
      "boolValue": false,
      "sliderValue": 1.0,
    },
    {
      "id": 2,
      "title": "Erosion",
      "boolValue": false,
      "sliderValue": 1.0,
    },
    {
      "id": 3,
      "title": "Cracks",
      "boolValue": false,
      "sliderValue": 1.0,
    },
    {
      "id": 4,
      "title": "Sliding/Piping",
      "boolValue": false,
      "sliderValue": 1.0,
    },
    {
      "id": 5,
      "title": "Depressions and settlement",
      "boolValue": false,
      "sliderValue": 1.0,
    },
    {
      "id": 6,
      "title": "Alignment change",
      "boolValue": false,
      "sliderValue": 1.0,
    },
    {
      "id": 7,
      "title": "Dislocation",
      "boolValue": false,
      "sliderValue": 1.0,
    },
  ];

  getFilteredData() {
    var filteredData = [];
    for (var item in data) {
      //print("\n$item\n");
      if (item['boolValue']) filteredData.add(item);
    }
    //print("Dataaaaaaaaaaa\n$filteredData\n");
    return filteredData;
  }

  Future<bool> sendEmergencyReportToServer(var data) async {
    var prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("user");
    var place = widget.getRegionData();
    var dataToSend = {
      "state": place['state'],
      "district": place['district'],
      "region": place['region'],
      "reporter": user,
      "report-type": "emergency",
      "data": data
    };
    print("Sending data to server...\n$dataToSend");
    bool flag = false;
    String message;
    try {
      var response = await http.post(SERVER_URL + '/api/emergency',
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
          body: jsonEncode(dataToSend));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        flag = jsonResponse['status'] == 1 ? true : false;
        message = jsonResponse['message'];
      } else {
        message = "Some error occured...";
      }
    } on TimeoutException catch (timeoutError) {
      message = "Connection timed out...";
    } on SocketException catch (socketException) {
      message = "Some error occured...Please try again";
    } on Error catch (err) {
      message = "Some error occured...Please try again";
    }
    snackBar = SnackBar(
      content: Text(message),
    );
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                        "Below mentioned are some of the most relevant categories of embankment emergency conditions.\nPlease select most appropriate ones."),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        ...data.map((category) => categoryCheckBox(
                            category['id'],
                            category['title'],
                            category['boolValue'],
                            category['sliderValue']))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: messageBox(),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: isVisible
                          ? CircularProgressIndicator(
                              backgroundColor: myYellow,
                            )
                          : RaisedButton(
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: myBlue,
                              onPressed: () async {
                                setState(() {
                                  isVisible = true;
                                });
                                var sent = await sendEmergencyReportToServer(
                                    await getFilteredData());
                                setState(() {
                                  isVisible = false;
                                });
                                if (sent) {
                                  //success
                                  Scaffold.of(context).showSnackBar(snackBar);
                                  Timer(Duration(milliseconds: 2000),
                                      () => Navigator.pop(context));
                                } else {
                                  //error
                                  Scaffold.of(context).showSnackBar(snackBar);
                                }
                              },
                            ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget categoryCheckBox(
      int id, String title, bool boolValue, double sliderValue) {
    return Column(
      children: <Widget>[
        //checkbox row
        Row(
          children: <Widget>[
            Checkbox(
              value: boolValue,
              onChanged: (value) {
                print("Value:$value");
                setState(() {
                  //print(data[id - 1]);
                  data[id - 1]['boolValue'] = value;
                  print(data[id - 1]);
                  if (value == true) data[id - 1]['sliderValue'] = 0.0;
                });
              },
            ),
            Text(title),
          ],
        ),
        //slider row
        boolValue
            ? Slider(
                value: sliderValue,
                min: 0,
                max: 2,
                divisions: 2,
                activeColor: sliderValue == 0.0
                    ? myYellow
                    : sliderValue == 1.0 ? Colors.orange : Colors.red,
                inactiveColor: myBlack,
                label: sliderValue == 0.0
                    ? 'low'
                    : sliderValue == 1.0 ? 'mid' : 'high',
                onChanged: (sliderValue) {
                  print("SliderValue:$sliderValue");
                  setState(() {
                    data[id - 1]['sliderValue'] = sliderValue;
                    print("Slider Value of ${data[id - 1]}: $sliderValue");
                  });
                })
            : Container(),
      ],
    );
  }

  Widget messageBox() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: myBlue,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: msgController,
        maxLines: 10,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: "Write some more message if any...",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
