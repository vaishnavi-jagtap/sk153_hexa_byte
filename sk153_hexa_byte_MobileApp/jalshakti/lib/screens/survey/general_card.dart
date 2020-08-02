import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GeneralCard extends StatefulWidget {
  final String ques;
  final List<dynamic> ans;
  final int index;
  final Function onAnswerChanged;

  GeneralCard(this.index, this.onAnswerChanged, this.ques, this.ans);

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
      options, Function onAnswerChanged, int index) {
    List<Widget> widgets = [];

    for (List option in options) {
      widgets.add(RadioListTile(
        value: option[0].toString(),
        groupValue: selectedOption,
        title: Text(option[1]),
        onChanged: (currentOption) {
          print(index);
          onAnswerChanged(index, currentOption);
          setSelectedOption(currentOption);
        },
        selected: selectedOption == option[0],
      ));
    }
    return widgets;
  }
}
