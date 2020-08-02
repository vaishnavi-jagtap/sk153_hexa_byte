import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:jalshakti/classes/Constants.dart';
import 'package:jalshakti/classes/location_accessor.dart';
import '../screens/camera_screen.dart';
import '../screens/survey/before_general_question_screen.dart';
import '../classes/upload_data.dart';
import '../classes/survey_data_store.dart';
import '../screens/survey/question_answer_data.dart';

CameraDescription firstCamera;

Future initialize() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  firstCamera = cameras.first;

  //fetch surveyQuestions from server...
  var prefs = await SharedPreferences.getInstance();
  String lang = prefs.getString('languageCode');
  var jsonResponse;
  try {
    var response = await http.post(SERVER_URL + '/api/getSurveyQuestions',
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode({"language": lang}));

    if (response.statusCode == 200) {
      jsonResponse = jsonDecode(response.body);
      print(jsonResponse['message']);
      QuestionAnswer.generalQuestions =
          jsonResponse['questions']['generalSurveyQuestions'];
      QuestionAnswer.detailedQuestions =
          jsonResponse['questions']['detailedSurveyQuestions'];
    } else {
      print(response.statusCode);
    }
  } on TimeoutException catch (e) {
    print("Timeout exception...(survey page)");
  } on SocketException catch (e) {
    print("Socket exception...(survey page)");
    print(e);
  } on Exception catch (e) {
    print("Some error occurred....(survey page)");
  }
}

class Surveypage extends StatefulWidget {
  final String imagePath;
  Surveypage(this.imagePath) {
    initialize();
    debugPrint("Camera initialized..........");
  }

  @override
  _SurveypageState createState() => _SurveypageState(imagePath);
}

class _SurveypageState extends State<Surveypage>
    with SingleTickerProviderStateMixin {
  var _image;
  Map<String, double> _location = {};
  String _currentAddress;
  bool _locationFetched = false;
  AnimationController _refreshAnimator;

  _SurveypageState(imagePath) {
    this._image = imagePath;
    _location = {"latitude": 0.0, "longitude": 0.0};
    _currentAddress = "No address";
  }

  @override
  void initState() {
    _refreshAnimator = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));

    super.initState();
  }

  @override
  void dispose() {
    _refreshAnimator.dispose();
    super.dispose();
  }

  setImagePath(imagePath) {
    setState(() {
      _image = imagePath;
    });
    this._image = imagePath;
    print("Image path(survey page): " + this._image);
  }

  sendImageToServer(imagePath) async {
    UploadData request = UploadData();
    bool sent = await request.sendImageDataToServer(
        imagePath, '/api/survey/uploadImage');
    if (sent) {
      print(request.getResponse());
      SurveyDataStore.imageURL = request.getResponse();
    } else {
      print(request.getErrorResponse());
    }
  }

  fetchLocation() async {
    LocationAccessor loc = LocationAccessor();
    try {
      if (await loc.fetchLocation()) {
        String address = await loc.getAddressFromLatLng(
            loc.getLatitude(), loc.getLongitude());
        setState(() {
          _location["latitude"] = loc.getLatitude();
          _location["longitude"] = loc.getLongitude();
          print("Location : $_location");
          //SurveyDataStore.latitude = loc.getLatitude();
          //SurveyDataStore.longitude = loc.getLongitude();
          _currentAddress = address;
          _locationFetched = true;
          print("Address:$_currentAddress");
        });
      } else {
        print("Error:" + loc.getError());
      }
    } catch (e) {
      print("Error getting address : $e");
    }
    Timer(Duration(seconds: 2), () => _refreshAnimator.stop());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              //background
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
              //main content
              mainContent(context),
              //MainContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget myAppBar(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                //go to home page
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Jal Shakti",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget mainContent(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        myAppBar(context),
        Stack(
          children: <Widget>[
            //the vertical line
            Container(
              margin: EdgeInsets.only(top: 10, left: 30, right: 10),
              padding: EdgeInsets.only(top: 10, right: 10),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
              ),
              height: size.height * 0.9,
              width: size.width * 0.95,
            ),

            //cards of first three steps
            Container(
              margin: EdgeInsets.only(top: 10, left: 15, right: 10),
              padding: EdgeInsets.only(top: 10, right: 10),
              height: size.height * 0.9,
              width: size.width * 0.95,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    //1st row for step one
                    Padding(
                      padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                      child: Row(
                        children: stepOneCard(context),
                      ),
                    ),
                    //2nd row for subtask(display image)
                    Padding(
                      padding: EdgeInsets.only(left: 5, top: 10, bottom: 10),
                      child: Row(
                        children: stepOneImageCard(context),
                      ),
                    ),
                    //3rd row for step two(location)
                    Padding(
                      padding: EdgeInsets.only(left: 0, top: 10, bottom: 40),
                      child: Row(
                        children: stepTwoCard(context),
                      ),
                    ),
                    //4th row for continue button
                    _locationFetched && _image != "no-image"
                        ? Padding(
                            padding:
                                EdgeInsets.only(left: 0, top: 10, bottom: 40),
                            child: Row(
                              children: stepThreeCard(context),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> stepOneCard(context) {
    var size = MediaQuery.of(context).size;
    return [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Center(
          child: Text(
            "1",
            style: TextStyle(color: Colors.deepPurple),
          ),
        ),
      ),
      SizedBox(
        width: 20,
        height: 5,
        child: Container(
          padding: EdgeInsets.zero,
          color: Colors.white,
        ),
      ),
      Container(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.zero,
          //color: Colors.grey,
          child: Container(
            padding: EdgeInsets.all(10),
            width: size.width * 0.7,
            child: Wrap(
              children: <Widget>[
                Text(
                  "Before taking the survey, it is necessary that you actually visit a nearby river embankment and then answer all the questions.\nThe first step of the survey insists on clicking an image of the embankment.\nIt is necessary to have it as a proof.",
                  style: TextStyle(color: myBlack),
                ),
              ],
            ),
          ),
        ),
      )
    ];
  }

  List<Widget> stepOneImageCard(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return [
      Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
      ),
      SizedBox(
        width: 20,
        height: 5,
        child: Container(
          padding: EdgeInsets.zero,
          color: Colors.white,
        ),
      ),
      Container(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.zero,
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.all(10),
            width: size.width * 0.7,
            child: Wrap(
              children: <Widget>[
                _image == "no-image"
                    ? requestImageCard(context)
                    : Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Captured Photo",
                              style: TextStyle(color: myBlack),
                            ),
                          ),
                          Divider(),
                          Image.file(
                            File(_image),
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      )
    ];
  }

  Widget requestImageCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Please click a photo of embankment wherever there is any kind of destruction",
            style: TextStyle(color: myBlack),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: RaisedButton(
              child: Text(
                'Click Picture',
                style: TextStyle(color: Colors.white),
              ),
              color: myBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TakePictureScreen(
                      camera: firstCamera, setImage: setImagePath);
                }));
              }),
        ),
      ],
    );
  }

  List<Widget> stepTwoCard(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Center(
          child: Text(
            "2",
            style: TextStyle(color: Colors.deepPurple),
          ),
        ),
      ),
      SizedBox(
        width: 20,
        height: 5,
        child: Container(
          padding: EdgeInsets.zero,
          color: Colors.white,
        ),
      ),
      Container(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.zero,
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.all(10),
            width: size.width * 0.7,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Icon(Icons.location_on, color: Colors.redAccent),
                          Text(
                            "Location",
                            style: TextStyle(color: myBlack),
                          ),
                        ],
                      ),
                      Divider(
                        endIndent: size.width * 0.1,
                        color: myYellow,
                      ),
                      Wrap(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            _currentAddress,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: RotationTransition(
                    turns:
                        Tween(begin: 0.0, end: 10.0).animate(_refreshAnimator),
                    child: IconButton(
                      icon: Icon(Icons.refresh),
                      color: myBlue,
                      onPressed: () {
                        _refreshAnimator.repeat();
                        fetchLocation();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    ];
  }

  List<Widget> stepThreeCard(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Center(
          child: Text(
            "3",
            style: TextStyle(color: Colors.deepPurple),
          ),
        ),
      ),
      SizedBox(
        width: 20,
        height: 5,
        child: Container(
          padding: EdgeInsets.zero,
          color: Colors.white,
        ),
      ),
      Container(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.zero,
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.all(10),
            width: size.width * 0.7,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Text(
                    "Continue to the survey...",
                    style: TextStyle(color: myBlack),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: RaisedButton(
                        child: Text(
                          'Continue',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: myBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          sendImageToServer(_image);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return BeforeGeneralQuestionScreen();
                          }));
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    ];
  }
}
