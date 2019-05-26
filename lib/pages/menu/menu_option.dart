import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/pages/error/no_connection.dart';
import '../quiz/quiz_page.dart';
import './chip_select.dart';
import '../error/no_ques.dart';

class OptionPage extends StatefulWidget {
  String category = "General Knowledge"; /// Defualt Values
  int id = 9;
  OptionPage(this.category, this.id);
  createState() => OptionState();
}

class OptionState extends State<OptionPage> {
  String difficulty = 'easy'; /// Defualt Values
  String noOfQues = '10';
  changeDifficulty(String diff) { /// For Selection of Settings
    difficulty = diff.toLowerCase();
    print(difficulty);
  }

  changeNoOfQues(String newNoOfQues) { /// For Selection of Settings
    noOfQues = newNoOfQues;
    print(noOfQues);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.category,
            style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          leading: IconButton(  // Closing Button For Page
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),

          SizedBox(
            height: 50,
          ),
          Text(  // No. of Question Selection
            'Number of questions',
            style: TextStyle(fontSize: 30.0, color: Color(0xFF333333)),
          ),
          SelectChip(['10', '20', '30', '40', '50'], changeNoOfQues, "10"),
          Text(
            'Difficulty',
            style: TextStyle(fontSize: 30.0, color: Color(0xFF333333)),
          ),
          SelectChip(['Easy', 'Medium', 'Hard'], changeDifficulty, "Easy"), // Difficulty Selection
          Builder(
            builder: (context) =>
                _optionButton("Star Quiz", Colors.green[300], context),
          )
        ],
      ),
    );
  }

  _optionButton(optionValue, buttonColor, BuildContext context) {
    fetchData(String url, bool defaultRequest) async {  // For retriving Quiz in Json Form
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> result = json.decode(response.body)["results"];
        if (result.length == 0 && defaultRequest == true) {  // If not enough questions at particular difficulty
                                                             // then request ques from all difficulty levels.
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => NoQuesError()));
        } else if (result.length == 0 && defaultRequest == false) {  // requesting questions for given settings
          String defaultUrl = "https://opentdb.com/api.php?amount=" +
              noOfQues.toString().toLowerCase() +   
              "&category=" +
              widget.id.toString() +
              "&type=multiple";         //Creating  Default request URL
          fetchData(defaultUrl, true);
          return;
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => QuizPage(result))); // Pass Data to Quiz Page
        }
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load post');
      }
    }

    request(BuildContext context, String noOfQues, String difficulty) async {
      final snackBar = SnackBar(  //To show loading sign while quiz is fetched from API
        content: Text('Loading...'),
        duration: Duration(minutes: 1),
      );
      Scaffold.of(context).showSnackBar(snackBar);

      print("REquesting");
      var url = "https://opentdb.com/api.php?amount=" +
          noOfQues.toString().toLowerCase() +
          "&category=" +
          widget.id.toString() +
          "&difficulty=" +
          difficulty.toLowerCase() +
          "&type=multiple";
      print(url);
      try {   //Check Connectivity with API
        final result = await InternetAddress.lookup('opentdb.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
        }
      } on SocketException catch (_) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => NoConnectionError()));
      }
      fetchData(url, false);
    }

    buttonPressed() {
      request(context, noOfQues, difficulty); //Create URL and fetch Data
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
