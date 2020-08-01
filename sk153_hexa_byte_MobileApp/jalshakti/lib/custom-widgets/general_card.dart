import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GeneralCard extends StatefulWidget {

  final String ques, imgurl;
  final List<String> ans;
  final index;
  final Function onAnswerChanged;

  GeneralCard(this.index, this.onAnswerChanged, this.ques, this.imgurl, this.ans);

@override
  _GeneralCardState createState() => _GeneralCardState();
}

class _GeneralCardState extends State<GeneralCard> {

  String selectedOption;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(widget.ques),
            contentPadding: EdgeInsets.all(10.0),
          ),
          Column(
            children: <Widget>[
              //Image.asset(widget.imgurl),
              Column(
                children: createRadioListOptions(
                    widget.ans, widget.onAnswerChanged, widget.index),
              ),
            ],
          ),
        ],
      ),
    
      );
  }

  setSelectedOption(value) {
    setState(() {
      selectedOption = value;
    });
  }
  
   List<Widget> createRadioListOptions(
      List<String> options, Function onAnswerChanged, int index) {
    List<Widget> widgets = [];
    
        for (String option in options) {
      widgets.add(RadioListTile(
        value: option,
        groupValue: selectedOption,
        title: Text(option),
        onChanged: (currentOption) {
          //print("Current Option: " + currentOption);
          //print("Card index: ");
          print(index);
          onAnswerChanged(index, currentOption);
          setSelectedOption(currentOption);
          
        },
        selected: selectedOption == option,
      ));
    }
    return widgets;
  }


}

