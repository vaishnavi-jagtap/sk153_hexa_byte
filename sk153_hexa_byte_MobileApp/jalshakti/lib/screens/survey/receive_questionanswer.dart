import 'package:flutter/material.dart';
import './question_answer_data.dart';
import './new_card.dart';

class ReceiveQuestionAnswer extends StatefulWidget {
  @override
  _ReceiveQuestionAnswerState createState() => _ReceiveQuestionAnswerState();
}

class _ReceiveQuestionAnswerState extends State<ReceiveQuestionAnswer> {
  final questionanswer = QuestionAnswer.generalQuestions;
  Map<String, String> surveyData =
      {}; //contains the questions number and corresponding answer
  var selectedOption = '';
  @override
  void initState() {
    super.initState();
    print(questionanswer);
    for (int i = 0; i < questionanswer.length; i++) {
      surveyData[i.toString()] = '';
    }
  }

  onAnswerChanged(int index, String value) {
    setState(() {
      surveyData[index.toString()] = value;
    });
    print("Survey data:");
    print(surveyData);
  }

  setSelectedOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (var i = 0; i < questionanswer.length; i++)
              NewCard(i, onAnswerChanged, questionanswer[i]["question"],
                  questionanswer[i]["imgurl"], questionanswer[i]["answers"]),
            Container(
              child: RaisedButton(
                  child: Text("Finish"),
                  color: Colors.blue[200],
                  onPressed: () {
                    //send survey data to server
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
