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
                title: Text(
                    "Let us first understand some general information about river embankments. River embankments are water retaining structures that safeguard river surroundings."),
                subtitle:
                    Text("Please click on the button below to continue..."),
              ),
              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    child: Text("Continue"),
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
