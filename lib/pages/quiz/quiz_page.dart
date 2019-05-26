///
/// The quiz page with list of questions and storing score.
///

import 'package:flutter/material.dart';
import 'quiz_format.dart';
import '../result/result_page.dart';
import '../menu/menu_page.dart';

class QuizPage extends StatefulWidget {
  List questions;
  QuizPage(this.questions) {
    for (Map ques in questions) {
      List temp = [];
      temp.addAll(ques["incorrect_answers"]);
      temp.add(ques["correct_answer"]);
      temp.shuffle();
      ques.putIfAbsent("options", () => temp);
    }
  }

  int index = 0;  // index of question in list
  double score = 0.0; // for Storing Score
  int correctAnswers = 0; // No. of Correct Answers

  int incorrectAnswers = 0;  // No. of Incorrect Answers
  createState() => QuizState();
}

class QuizState extends State<QuizPage>  with AutomaticKeepAliveClientMixin {
  Future<bool> _onWillPop() { // on pressed Back button
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to quit the Quiz?'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () { // no Action
                      Navigator.pop(context);
                    },
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () { // NAvigating Back to The Menu Page
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
    return WillPopScope( //Wrapping for listening back button
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Color(0xFF363333),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text( // Displaing Question number
                    ' QUESTION   ' +
                        (widget.index + 1).toString() +
                        ' / ' +
                        (widget.questions.length).toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    "Score:" + widget.score.toInt().toString(), // TO display Score
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            // Child widget for Displaying questions and options
            Flexible(child: QuizFormat(widget.questions[widget.index], update)), 
          ],
        ),
      ),
    );
  }
  // Updating the score and number of correct, incorrect answers
  update(double scoreUpdate) {
    if (scoreUpdate == 100.0) {
      widget.correctAnswers++;
    } else {
      widget.incorrectAnswers++;
    }

    setState(
      () {
        if (widget.index < widget.questions.length - 1) { // if Still questions in list
          widget.index += 1;
          widget.score += scoreUpdate;
        } else {      // Questions over
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ResultPage({
                    'score': widget.score,
                    'correct': widget.correctAnswers,
                    'incorrect': widget.incorrectAnswers
                  }),
            ),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
