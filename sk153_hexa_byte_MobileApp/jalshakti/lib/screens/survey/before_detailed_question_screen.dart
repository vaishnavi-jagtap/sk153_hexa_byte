import 'package:jalshakti/classes/localization/localization.dart';

import 'detailed_question_answer.dart';
import 'package:flutter/material.dart';

class BeforeDetailedQuestionScreen extends StatelessWidget {
  var gen;
  BeforeDetailedQuestionScreen({this.gen});
  @override
  Widget build(BuildContext context) {
    print("Before detailed survey......\n");
    print(gen);
    return Scaffold(
      body: Center(
        child: Card(
          margin: EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(AppLocalizations.of(context).beforeDetailedInfo),
                subtitle:
                    Text("Please click on the button below to continue..."),
              ),
              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    child: Text(AppLocalizations.of(context).next),
                    color: Colors.blue,
                    onPressed: () {
                      print(
                          "General question answer data .....................");
                      print(gen);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReceiveDetailedQuestionAnswer(
                                  gen1: gen,
                                )),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
