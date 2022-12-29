import 'package:flutter/material.dart';

import 'ui/screens/home/home_screen.dart';

class MachineTestApp extends StatelessWidget {
  const MachineTestApp({super.key});

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
