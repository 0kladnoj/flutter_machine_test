import 'package:flutter/material.dart';

import 'di/di.dart';
import 'ui/screens/home/home_screen.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

// TODO(Dima): 1) Rename 2) Extract to a separate file
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter machine test',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}
