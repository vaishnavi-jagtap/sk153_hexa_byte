import 'package:flutter/material.dart';
import 'package:jalshakti/classes/Constants.dart';
import 'package:jalshakti/custom-widgets/admin_login/admin_login_modal.dart';
import 'package:jalshakti/custom-widgets/permission_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:jalshakti/classes/localization/localization.dart';
import 'package:jalshakti/main.dart';
import 'package:jalshakti/custom-widgets/admin_drawer.dart';
import 'package:jalshakti/screens/more_info.dart';
import '../custom-widgets/introduction_card.dart';
import './survey_page.dart';

class JalShaktiHome extends StatefulWidget {
  final String user;
  JalShaktiHome({this.user});
  @override
  _JalShaktiHomeState createState() => _JalShaktiHomeState(user);
}

class _JalShaktiHomeState extends State<JalShaktiHome> {
  //required for localization
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // List<RadioModel> _langList = new List<RadioModel>();
  int _index = 0;
  bool languageMenuShown = false;
  ///////////////////////////
  final String user;
  var permissions = false;
  String locale = 'en';

  _JalShaktiHomeState(this.user);

  @override
  void initState() {
    super.initState();
    _updateLocale(locale, '');
    //_getLangList();
    getPermissions();
  }

  getPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
    ].request();
    if (statuses[Permission.camera].isGranted &&
        statuses[Permission.location].isGranted) {
      setState(() {
        permissions = true;
      });
    } else {
      setState(() {
        permissions = false;
      });
    }
  }

  void _updateLocale(String lang, String country) async {
    print(lang + ':' + country);

    var prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', lang);
    prefs.setString('countryCode', country);

    MyApp.setLocale(context, Locale(lang, country));
  }

  Widget _homeAppBar(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: user == "admin"
                ? IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  )
                : Container(),
          ),
          Expanded(
            flex: 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).appName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: locale == 'en' ? 'MeriendaOne' : 'Gotu'),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: IconButton(
              icon: ImageIcon(
                AssetImage('assets/images/hindiTOenglish.png'),
                color: locale == 'en' ? Colors.white : Colors.yellowAccent,
              ),
              tooltip: "Change language",
              onPressed: () {
                //change lauguage
                setState(() {
                  locale == 'en' ? locale = 'hi' : locale = 'en';
                  _updateLocale(locale, '');
                });
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: IconButton(
              icon: Icon(
                Icons.help_outline,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MoreInfo();
                }));
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: user == "admin" ? AdminDrawer() : null,
          body: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff14235e),
                      Color(0xffc68ebd),
                      Color(0xffffd3be),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          //home app bar
                          _homeAppBar(context),
                          Center(
                            child: IntroductionCard(),
                          ),
                          !permissions
                              ? PermissionRequestCard(getPermissions)
                              : Visibility(
                                  child: Text(""),
                                  visible: false,
                                ),

                          Container(
                            height: 45,
                            width: 100,
                            margin: EdgeInsets.only(
                              top: 20,
                              bottom: 20,
                            ),
                            child: RaisedButton(
                              child: Text(
                                AppLocalizations.of(context).startSurvey,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              elevation: 5,
                              color: myBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Surveypage("no-image");
                                }));
                              },
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                    user == "admin" ? Container() : AdminLoginModal(),
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
