import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


//MultipleChoiceCard
class MultipleChoiceCard extends StatefulWidget {
  final String ques, imgurl;
  final List<String> ans;
  final index;
  final Function onAnswerChanged;

  MultipleChoiceCard(this.index, this.onAnswerChanged, this.ques, this.imgurl, this.ans);


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


//*************************************************************************************************************** */

//_MultipleChoiceImageCard
class MultipleChoiceImageCard extends StatefulWidget {
  final String ques, imgurl;
  final List<String> ans;
  final index;
  final Function onAnswerChanged;

  MultipleChoiceImageCard(this.index, this.onAnswerChanged, this.ques, this.imgurl, this.ans);


@override
 _MultipleChoiceImageCardState createState() => _MultipleChoiceImageCardState();
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
              Image.asset(widget.imgurl),
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


//*************************************************************************************************************** */

//ImageChoiceCard
class ImageChoiceCard extends StatefulWidget {
  final String ques;
  final List<String> ans;
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
      List<String> options, Function onAnswerChanged, int index) {
    List<Widget> widgets = [];
    
        for (String option in options) {
      widgets.add(RadioListTile(
        value: option,
        groupValue: selectedOption,
        title: Image.asset(option),
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

//***************************************************************************************************************

//SliderCard
class SliderCard extends StatefulWidget {
  final String ques;
  //final List<String> ans;
  final index;
  final Function onAnswerChanged2;

  SliderCard(this.index ,this.onAnswerChanged2, this.ques,);


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
                    label: '$value',       // _value gives the value marked
                    onChanged: (double newValue) {
                                  setState(() {
                                    value = newValue.round();
                                  });
                                  widget.onAnswerChanged2(widget.index,value);
                                        print("value of silder $value");
                                  },
                                  semanticFormatterCallback: (double newValue) {
                                       return '${newValue.round()}';
                                               }
                                                ),
                                                   ),
                                                            Text('10'),
                                                                      ]
                                                                    )
                                                                  ),
                                                                ),
                                        ],
                                      ),
                                );
                              }
                            
                             

}