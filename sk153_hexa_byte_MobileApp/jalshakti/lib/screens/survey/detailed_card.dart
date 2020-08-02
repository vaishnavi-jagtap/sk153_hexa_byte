import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jalshakti/classes/Constants.dart';

//MultipleChoiceCard
class MultipleChoiceCard extends StatefulWidget {
  final String ques, imgurl;
  final List<dynamic> ans;
  final index;
  final Function onAnswerChanged;

  MultipleChoiceCard(
      this.index, this.onAnswerChanged, this.ques, this.imgurl, this.ans);

  @override
  _MultipleChoiceCardState createState() => _MultipleChoiceCardState();
}

class _MultipleChoiceCardState extends State<MultipleChoiceCard> {
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
      options, Function onAnswerChanged, int index) {
    List<Widget> widgets = [];

    for (List option in options) {
      widgets.add(RadioListTile(
        value: option[0].toString(),
        groupValue: selectedOption,
        title: Text(option[1]),
        onChanged: (currentOption) {
          onAnswerChanged(index, currentOption);
          setSelectedOption(currentOption);
        },
        selected: selectedOption == option[0],
      ));
    }
    return widgets;
  }
}

//****************************************************************************************************************//

//_MultipleChoiceImageCard
class MultipleChoiceImageCard extends StatefulWidget {
  final String ques, imgurl;
  final List<dynamic> ans;
  final index;
  final Function onAnswerChanged;

  MultipleChoiceImageCard(
      this.index, this.onAnswerChanged, this.ques, this.imgurl, this.ans);

  @override
  _MultipleChoiceImageCardState createState() =>
      _MultipleChoiceImageCardState();
}

class _MultipleChoiceImageCardState extends State<MultipleChoiceImageCard> {
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
              Image.network(SERVER_URL + widget.imgurl),
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
          onAnswerChanged(index, currentOption);
          setSelectedOption(currentOption);
        },
        selected: selectedOption == option[0],
      ));
    }
    return widgets;
  }
}

//****************************************************************************************************************/

//ImageChoiceCard

class ImageChoiceCard extends StatefulWidget {
  final String ques;
  final List<dynamic> ans;
  final index;
  final Function onAnswerChanged;

  ImageChoiceCard(this.index, this.onAnswerChanged, this.ques, this.ans);

  @override
  _ImageChoiceCardState createState() => _ImageChoiceCardState();
}

class _ImageChoiceCardState extends State<ImageChoiceCard> {
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
      //print(option);
      widgets.add(RadioListTile(
        value: option[0].toString(),
        groupValue: selectedOption,
        title: option[1] != "null"
            ? Image.network(SERVER_URL + option[1])
            : Text(option[2]),
        onChanged: (currentOption) {
          onAnswerChanged(index, currentOption);
          setSelectedOption(currentOption);
        },
        selected: selectedOption == option[0],
      ));
    }
    return widgets;
  }
}

//***************************************************************************************************************

//SliderCard
class SliderCard extends StatefulWidget {
  final String ques;
  //final List<String> ans;
  final index;
  final Function onAnswerChanged2;

  SliderCard(
    this.index,
    this.onAnswerChanged2,
    this.ques,
  );

  @override
  SliderCardState createState() => SliderCardState();
}

class SliderCardState extends State<SliderCard> {
  String selectedOption;
  int value = 6;

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
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                  Text('0'),
                  new Expanded(
                    child: Slider(
                        value: value.toDouble(),
                        min: 0.0,
                        max: 10.0,
                        divisions: 10,
                        activeColor: Colors.blue,
                        inactiveColor: Colors.black,
                        label: '$value',
                        onChanged: (double newValue) {
                          setState(() {
                            value = newValue.round();
                          });
                          widget.onAnswerChanged2(widget.index, value);
                          print("value of silder $value");
                        },
                        semanticFormatterCallback: (double newValue) {
                          return '${newValue.round()}';
                        }),
                  ),
                  Text('10'),
                ])),
          ),
        ],
      ),
    );
  }
}
