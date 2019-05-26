import 'package:flutter/material.dart';
import 'package:quiz_app/pages/menu/menu_page.dart';


///
/// TO display When question are not available
///
class NoQuesError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.blue,
      child: new InkWell(
        onTap: () { //Redirect to Menu Page
          print("calling Function");
          Navigator.push(
              context,
              MaterialPageRoute<Null>(
                builder: (BuildContext context) => MenuPage(),
                fullscreenDialog: true,
              ));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              color: Colors.yellow,
              size: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "We Are Getting More Questions, \nPlease Select Different Setings",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Tap To Retry",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
