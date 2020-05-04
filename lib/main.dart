import 'package:flutter/material.dart';
import 'package:nlp_flutter/src/pages/speech_to_text.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var themeData = ThemeData(       
        primarySwatch: Colors.blue,
      );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Speech to Text',
      theme: themeData,
      home: SpeechToTextPage(),
    );
  }
}