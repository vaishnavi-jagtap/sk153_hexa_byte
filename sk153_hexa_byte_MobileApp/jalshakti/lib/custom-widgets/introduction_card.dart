import 'package:flutter/material.dart';
import 'package:jalshakti/classes/localization/localization.dart';

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
          child: Text(AppLocalizations.of(context).introduction),
        ),
      ),
    );
  }
}
