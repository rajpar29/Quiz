///
///  For Displaying All the Categories of Quiz
///


import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import './menu_option.dart';

class MenuPage extends StatefulWidget {
  createState() => MenuState();
}

class MenuState extends State<MenuPage> {
  // List of Categories
  List categories = [
    {"id": 9, "name": "General Knowledge"},
    {"id": 10, "name": "Books"},
    {"id": 11, "name": "Film"},
    {"id": 12, "name": "Music"},
    {"id": 13, "name": "Musicals & Theatres"},
    {"id": 14, "name": "Television"},
    {"id": 15, "name": "Video Games"},
    {"id": 16, "name": "Board Games"},
    {"id": 17, "name": "Science & Nature"},
    {"id": 18, "name": "Computers"},
    {"id": 19, "name": "Mathematics"},
    {"id": 20, "name": "Mythology"},
    {"id": 21, "name": "Sports"},
    {"id": 22, "name": "Geography"},
    {"id": 23, "name": "History"},
    {"id": 24, "name": "Politics"},
    {"id": 25, "name": "Art"},
    {"id": 26, "name": "Celebrities"},
    {"id": 27, "name": "Animals"},
    {"id": 28, "name": "Vehicles"},
    {"id": 29, "name": "Comics"},
    {"id": 30, "name": "Gadgets"},
    {"id": 31, "name": "Japanese Anime & Manga"},
    {"id": 32, "name": "Cartoon & Animations"}
  ];
  List<Color> tileColors = [
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.indigo,
    Colors.lightBlue,
    Colors.amber,
    Colors.deepOrange,
    Colors.red,
    Colors.brown
  ]; // Colors for tiles
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 4, // Total cross axis Columns
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) => new Tile(
              // Choosing Random Colour
                (tileColors..shuffle()).first, categories[index]["name"], categories[index]["id"]),
            staggeredTileBuilder: (int index) {
              int tileHeight = 3;   //Deciding Height of Tiles
              if (index == categories.length - 1 || index == 0) {
                tileHeight = 2;
              }
              return StaggeredTile.count(2, tileHeight);  // Width and Height of TIle
            },
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          )),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile(this.backgroundColor, this.category, this.id);

  // Data for Tiles
  final Color backgroundColor;
  final String category;
  final int id;

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: backgroundColor,
      child: new InkWell(  // For Touch Events
        onTap: () {
          Navigator.push( // Navigate to Options Page for Difficulty selection.
              context,
              MaterialPageRoute<Null>(
                builder: (BuildContext context) => OptionPage(category,id),
                fullscreenDialog: true,
              ));
        },
        child: Center(
          child: Text(
            category,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
