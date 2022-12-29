import 'package:flutter/material.dart';

import 'di/di.dart';
import 'machine_test_app.dart';

void main() {
  configureDependencies();
  runApp(const MachineTestApp());
}
