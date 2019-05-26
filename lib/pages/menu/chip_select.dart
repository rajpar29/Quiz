///
/// Widget to select difficulty and no. of questions.
///


import 'package:flutter/material.dart';

class SelectChip extends StatefulWidget {
  final List<String> reportList;
  Function update;
  String defaultValue;

  SelectChip(this.reportList, this.update, this.defaultValue) {
    print(defaultValue);
  }
  @override
  _SelectChipState createState() => _SelectChipState(defaultValue);
}

class _SelectChipState extends State<SelectChip> {
  // this function will build and return the choice list
  String selectedChoice = "";
  _SelectChipState(this.selectedChoice); //Taking Default Selected Value

  _buildChoiceList() {  //Creating List Of Chips For A Given List
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: Transform(  // Increasing Size.
          transform: new Matrix4.identity()..scale(1.5),
          child: ChoiceChip(
            label: Text(item),
            selected: selectedChoice == item,
            onSelected: (selected) { // Selection Changed
              setState(() {
                selectedChoice = item;
                widget.update(selectedChoice); // Update in Parent Widget
              });
            },
          ),
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _buildChoiceList(),
          ),
        ],
      ),
    );
  }
}
