import 'package:flutter/material.dart';
import 'package:tpay_training/training_details/training_details.dart';
import 'package:tpay_training/training_summary/training_summary.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrainingDetails(),
    );
  }
}
