import 'package:agentcollection_newbank/app.dart';
import 'package:agentcollection_newbank/injector.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();
  runApp(MyApp());
}
