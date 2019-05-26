///
/// Widget For Displaying Questions and options. 
///

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class QuizFormat extends StatefulWidget {
  Map question;
  Function update;
  QuizFormat(this.question, this.update);

  List buttonClicked = [ // List to keep track of ["is button Pressed", The colour of button After pressed]
    [false, Colors.red[300]],
    [false, Colors.red[300]],
    [false, Colors.red[300]],
    [false, Colors.red[300]],
  ];
  @override
  State<StatefulWidget> createState() {
    return QuizState();
  }
}

class QuizState extends State<QuizFormat> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        _question(widget.question["question"]),
        Flexible(
          child: Container(),
        ),
        _optionButton(
            widget.question["options"][0],
            widget.buttonClicked[0][0]
                ? widget.buttonClicked[0][1]
                : Colors.white,
            0),
        _optionButton(
            widget.question["options"][1],
            widget.buttonClicked[1][0]
                ? widget.buttonClicked[1][1]
                : Colors.white,
            1),
        _optionButton(
            widget.question["options"][2],
            widget.buttonClicked[2][0]
                ? widget.buttonClicked[2][1]
                : Colors.white,
            2),
        _optionButton(
            widget.question["options"][3],
            widget.buttonClicked[3][0]
                ? widget.buttonClicked[3][1]
                : Colors.white,
            3),
      ],
    );
  }

  _question(String ques) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
      child: Text(
        HtmlUnescape().convert(ques), // To create  " sign 
        style: TextStyle(
          color: Colors.white,
          fontSize: 28.0,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _optionButton(optionValue, buttonColor, buttonNo) {
    buttonPressed() {
      {
        if (optionValue == widget.question["correct_answer"]) { // Check if Answer was right
          setState(() {
            widget.buttonClicked[buttonNo][0] = true; // Set button is clicked

            widget.buttonClicked[buttonNo][1] = Colors.green[300]; // Change correct option to Green colour
          });

          double tempScoreCalc = 0.0;  //for score calculation
          for (var item in widget.buttonClicked) {
            if (item[0] == false) { // check how may buttons were pressed
              tempScoreCalc += 25.0; // if only one button is pressed then score will be 100, i.e. only correct option was selected
            }
          }
          tempScoreCalc += 25.0;
          Future.delayed(const Duration(milliseconds: 500), // delay of half second so that user can see the right option
              () => widget.update(tempScoreCalc)); //updating the score and question in parent widget
        
         // Wrong Option Selected
        } else {
          setState(() {
            widget.buttonClicked[buttonNo][0] = true; //Set button pressed and color will be red
          });
        }
      }
    }

    return Row( // Option Button Widget
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(left: 10, right: 10),
            child: RaisedButton(
                child: Text(
                  HtmlUnescape().convert(optionValue),
                  style: TextStyle(color: Color(0xFF333333), fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
                elevation: 4.0,
                color: buttonColor,
                splashColor: Colors.white70,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(6.0),
                ),
                onPressed: buttonPressed),
          ),
        ),
      ],
    );
  }
}
