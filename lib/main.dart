import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './pages/menu/menu_page.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
  //debugPaintSizeEnabled = true;

  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  return;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(fontFamily: 'Slabo'), home: MenuPage());
  }
}
