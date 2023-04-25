import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'widgets/app/my_app.dart';

void main() {
  Hive.initFlutter();
  runApp( MyApp());
}


