import 'package:flutter/material.dart';
import '../classes/question_answer_data.dart';
import 'general_card.dart';
import '../screens/before_detailed_question_screen.dart';



class ReceiveGeneralQuestionAnswer extends StatefulWidget {
  @override
  _ReceiveGeneralQuestionAnswerState createState() => _ReceiveGeneralQuestionAnswerState();
}

class _ReceiveGeneralQuestionAnswerState extends State<ReceiveGeneralQuestionAnswer> {
  final generalquestionanswer = QuestionAnswer.generalquestionanswer;
 
 //contains the questions number and corresponding answer
  Map<String, String> surveyData0 = {}; 
    int _check = 0;
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < generalquestionanswer.length; i++) {
      surveyData0[i.toString()] = '';      //data is stored here
    }
  }

  onAnswerChanged(int index, String value) {
    setState(() {
      surveyData0[index.toString()] = value;    
       if(value != ''){
          _check++;
        }       
    });
   
    print("Survey data:");
    print(surveyData0);
  }

  void storedata(){

  // addAll() method
  final generalsurvey = surveyData0;
  print("Generalsurvey :::::::::::::::::::::::::::::::::::");
  print(generalsurvey);

  }

 

 @override
Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (var i = 0; i < generalquestionanswer.length; i++)
               GeneralCard(i,
                           onAnswerChanged,
                           generalquestionanswer[i]["question"],
                           generalquestionanswer[i]["imgurl"],
                           generalquestionanswer[i]["answers"]),
           
            Container(
              child: RaisedButton(
                  child: Text("Next"),
                  color: Colors.blue,
                  onPressed: () {
                   if(_check >= generalquestionanswer.length){
                     storedata();
                     Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => 
                    BeforeDetailedQuestionScreen(
                        gen : surveyData0,
                    )),
                   );//send survey data to server
                   }else{
                     SnackBar(content: Text("Please fill all the fields"));
                   }
                    
                             
                  }),
            ),
          ],
        ),
      ),
    );
  } 

}

