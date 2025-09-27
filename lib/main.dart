import 'package:challenges/presentations/screens/challenge_one.dart';
import 'package:challenges/presentations/screens/challenge_three.dart';
import 'package:challenges/presentations/screens/challenge_two.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:ChallengeOne(),
    );
  }
}

