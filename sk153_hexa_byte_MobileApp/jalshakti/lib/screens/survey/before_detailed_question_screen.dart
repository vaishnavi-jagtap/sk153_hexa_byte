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
                title: Text(
                    "Now let us have a detailed survey. Please observe every minute detail of the embankment you are near to. Taking into consideration all the knowledge that you have regarding embankments, please provide genuine answers to following questions."),
                subtitle:
                    Text("Please click on the button below to continue..."),
              ),
              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    child: Text("Continue"),
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
