///
/// To display the Score or result
///

import 'package:flutter/material.dart';
import '../../like_dislike_icon.dart';
import '../menu/menu_page.dart';

class ResultPage extends StatefulWidget {
  Map data;

  ResultPage(this.data);
  createState() => ResultState();
}

class ResultState extends State<ResultPage> {

   Future<bool> _onWillPop() { // to check for exit on back button press
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to quit?'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => MenuPage()));
                    },
                    child: new Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false;
   }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          // Display Score
          Text("Score: " + widget.data["score"].toInt().toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Color(0xFF333333))),
          SizedBox(
            height: 40,
          ),

          // Display Correct and incorrect no. of questions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(LikeDislike.thumbs_up_alt,
                      color: Colors.greenAccent, size: 80),
                  Text(
                    "RIGHT",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.data["correct"].toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Color(0xFF333333)),
                  ),
                ],
              ),
              Container(
                height: 100.0,
                width: 1.0,
                color: Colors.grey,
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              ),
              Column(
                children: <Widget>[
                  Icon(LikeDislike.thumbs_down_alt,
                      color: Colors.redAccent, size: 80),
                  Text(
                    "WRONG",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  Text(widget.data["incorrect"].toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color(0xFF333333))),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[],
          ),
          Flexible(child: Container(),),

          // Play again,  NAvigate to Menu Page
          _optionButton("Play Again", Colors.green[300]),
          SizedBox(height: 40,)
        ],
      ),
    ),);
  }

  _optionButton(optionValue, buttonColor) { // button Widget
    buttonPressed() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> MenuPage()));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(left: 10, right: 10),
            child: RaisedButton(
                child: Text(
                  optionValue,
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
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
