import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:jalshakti/classes/Constants.dart';
import 'package:jalshakti/classes/localization/localization.dart';

import 'state_district_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:jalshakti/classes/survey_data_store.dart';

//Form Screen
class UserDetailScreen extends StatefulWidget {
  var gen2;
  UserDetailScreen({Key key, @required this.gen2}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return UserDetailScreenState();
  }
}

class UserDetailScreenState extends State<UserDetailScreen> {
  var gen2;
  UserDetailScreenState({this.gen2});
  String _name;
  String _savedstate;
  String _saveddistrict;
  StateDistrict stateDistrict = StateDistrict();

  List<String> _states = ["Choose a state"];
  List<String> _district = ["Choose a district"];
  String _selectedState = "Choose a state";
  String _selectedDistrict = "Choose a district";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: AppLocalizations.of(context).userName),
      //keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name Required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  @override
  void initState() {
    _states = List.from(_states)..addAll(stateDistrict.getStates());
    super.initState();
  }

  Widget _buildDropdown() {
    return Column(
      children: <Widget>[
        DropdownButtonFormField<String>(
          isExpanded: true,
          items: _states.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),
          onChanged: (value) => _onSelectedState(value),
          value: _selectedState,
          validator: (String value) {
            if (value == "Choose a state") {
              return 'Field Required';
            }

            return null;
          },
          onSaved: (String value) {
            _savedstate = value;
          },
        ),
        DropdownButtonFormField<String>(
          isExpanded: true,
          items: _district.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),
          // onChanged: (value) => print(value),
          onChanged: (value) => _onSelectedDistrict(value),
          value: _selectedDistrict,
          validator: (String value) {
            if (value == "Choose a district") {
              return "Field required";
            }
            return null;
          },
          onSaved: (String value) {
            _saveddistrict = value;
          },
        ),
      ],
    );
  }

  void _onSelectedState(String value) {
    setState(() {
      _selectedDistrict = "Choose a district";
      _district = ["Choose a district"];
      _selectedState = value;
      _district = List.from(_district)
        ..addAll(stateDistrict.getLocalByState(value));
    });
  }

  void _onSelectedDistrict(String value) {
    setState(() => _selectedDistrict = value);
  }

  sendSurveyDataToServer(data) async {
    var x = {"a": "dff", "b": "asdffjfhfch"};

    print(jsonEncode(x));
    print("Sending data................${data} ");
    //print(surveyDataToJson(data));
    try {
      var response = await http.post(
          SERVER_URL + '/api/surveys/storeUserSurvey',
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        print("Data sent...");
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
      } else {
        print("Some error.......connecting....${response.statusCode}");
      }
    } on TimeoutException catch (e) {
      print("Timeout exception...");
    } on SocketException catch (e) {
      print("Socket exception...");
    } on Exception catch (e) {
      print("Some error occurred....");
    }
  }

/////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: new EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).userDetailInfo,
                style: TextStyle(fontSize: 16),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _buildName(),
                    SizedBox(height: 10),
                    _buildDropdown(),
                    SizedBox(height: 20),
                    RaisedButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }

                        _formKey.currentState.save();

                        print("Name  : " + _name);
                        print("State  : " + _savedstate);
                        print("District :  " + _saveddistrict);

                        var location = {
                          "latitude": SurveyDataStore.latitude.toString(),
                          "longitude": SurveyDataStore.longitude.toString()
                        };
                        var imageURL = SurveyDataStore.imageURL;
                        var now = new DateTime.now();
                        var dateTime =
                            DateFormat("dd-MM-yyyy-hh:mm:ss").format(now);
                        var surveyId = dateTime + _name;
                        var dataToSend = {
                          "surveyId": surveyId,
                          "surveyer": _name,
                          "state": _savedstate,
                          "district": _saveddistrict,
                          "image-url": imageURL,
                          "zone_id": "",
                          "date-time": dateTime.toString(),
                          "location": location,
                          "survey-status": "Pending",
                          "survey-data": widget.gen2
                        };
                        print(
                            "Send the data to server................................................");
                        try {
                          sendSurveyDataToServer(dataToSend);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        } on Exception catch (e) {
                          print("Exception:::::---$e");
                        } on Error catch (e) {
                          print("Error:::::---$e");
                          debugPrintStack();
                        }
                        //Send the data to server
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GetData extends StatelessWidget {
  final Map<String, String> data;
  GetData({this.data});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//    {"surveyer": "Sushant Said", "state": "Maharashtra", "district": "Pune", "image-url": "uploads/2020-07-25_122646.717620.png", "location": {"latitude": 18.9972279, "longitude": 73.9459255}, "survey-status": "Pending", "survey-data": {"detailed": {"multiple-choice": {"0": "Medium", "1": "No", "2": "B - Transverse (Perpendicular to the length)", "3": "Yes"," 4":"Short length plants", "5": "2", "6": "1"}, "slider": {"7": "3", "8": "8", "9": "3", "10": "8", "11": "3", "12": "8", "13": "3", "14": "10"}}, "general": {"0": "2011 – present", "1": "No destruction", "2": "No", "3": "Agricultural purpose", "4": "Yes", "5": "2-4 mtrs", "6": "Fast flowing winds but not having much impact on the natural and physical conditions of the embankment", "7": "No", "8": "Too wet(high moisture content)", "9": "Medium", "10": "Yes"}}};
