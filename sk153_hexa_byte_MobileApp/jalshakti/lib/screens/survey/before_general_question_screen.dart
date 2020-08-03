import 'package:jalshakti/classes/localization/localization.dart';

import 'general_question_answer.dart';
import 'package:flutter/material.dart';

class BeforeGeneralQuestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(AppLocalizations.of(context).beforeGeneralInfo),
                subtitle:
                    Text("Please click on the button below to continue..."),
              ),
              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    child: Text(AppLocalizations.of(context).step3continue),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ReceiveGeneralQuestionAnswer()),
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
