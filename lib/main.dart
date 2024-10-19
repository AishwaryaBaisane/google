import 'package:flutter/material.dart';
import 'package:google/Provider/Browser.dart';
import 'package:google/Screen/HomePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleController(),
        ),
      ],
      builder: (context, child) => const MyApp(),
    ),
  );
}


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
