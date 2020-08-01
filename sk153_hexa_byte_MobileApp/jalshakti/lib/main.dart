import 'package:flutter/material.dart';

import './screens/before_general_question_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final title = 'Survey';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
     // home: MyHomePage(title: 'Flutter Demo Home Page'),
       home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
          body: BeforeGeneralQuestionScreen(),
        ),
    );
  }
}
