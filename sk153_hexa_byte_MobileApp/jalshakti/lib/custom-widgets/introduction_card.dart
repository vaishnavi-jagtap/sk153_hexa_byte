import 'package:flutter/material.dart';
import 'package:jalshakti/classes/Constants.dart';

class IntroductionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      margin: EdgeInsets.all(20),
      //padding: EdgeInsets.all(30),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
              'What is this about?\n We intend to collect data regarding river embankments.\nSome more content here.\nThen convince the users to use this app'),
        ),
      ),
    );
  }
}
