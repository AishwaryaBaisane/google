import 'package:flutter/material.dart';
import 'package:google/Provider/Browser.dart';
import 'package:google/Screen/HomePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleController(),)
      ], builder: (context, child) => const MyApp()));
}


// search engine
// website_history_save
// back_and_ forward
//loader
// refresh
//user selective search_engine
//on click page of history
// home button


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

