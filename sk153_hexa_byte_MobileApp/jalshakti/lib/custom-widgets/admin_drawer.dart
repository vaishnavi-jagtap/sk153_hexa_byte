import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:jalshakti/classes/localization/localization.dart';

import '../screens/survey_page.dart';

class AdminDrawer extends StatelessWidget {
  final TextStyle drawerTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
  );
  final Color drawerIconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        child: Drawer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff2dc0c7),
                  Color(0xff30176b),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: DrawerHeader(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context).appName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                      ),
                      // decoration: BoxDecoration(
                      //   color: Colors.blue,
                      // ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context).approveSurveys,
                          style: drawerTextStyle,
                        ),
                        trailing: Icon(
                          Icons.assignment_turned_in,
                          color: drawerIconColor,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return SurveyApprovalScreen();
                          }));
                          
                        },
                      ),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context).survey,
                          style: drawerTextStyle,
                        ),
                        trailing: Icon(
                          Icons.assignment,
                          color: drawerIconColor,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Surveypage("no-image");
                          }));
                          
                        },
                      ),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context).reportProblem,
                          style: drawerTextStyle,
                        ),
                        trailing: Icon(
                          Icons.error_outline,
                          color: drawerIconColor,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return EmergencyReport();
                          }));
                        
                        },
                      ),
                      Divider(
                        endIndent: 10,
                      ),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context).about,
                          style: drawerTextStyle,
                        ),
                        trailing: Icon(
                          Icons.help_outline,
                          color: drawerIconColor,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return MoreInfo();
                            }),
                          );
                        },
                      ),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context).signOut,
                          style: drawerTextStyle,
                        ),
                        trailing: Icon(
                          Icons.power_settings_new,
                          color: drawerIconColor,
                        ),
                        onTap: () async {
                          var prefs = await SharedPreferences.getInstance();
                          prefs.setBool('isLoggedIn', false);

                          Navigator.of(context).pop();
                          
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return JalShaktiHome();
                          }));
                          
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
