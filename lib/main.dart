import 'package:agentcollection_newbank/NEW_BANK/data/remote/models/hive/loan_collection.dart';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_print.dart';
import 'package:agentcollection_newbank/app.dart';
import 'package:agentcollection_newbank/injector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  initializeHive();
  await setUp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

Future<void> initializeHive() async {
  try {
    await Hive.initFlutter();
    Hive.registerAdapter(LoanCollectionAdapter());
    await Hive.openBox<LoanCollection>('loanCollection');
    if (kDebugMode) {
      print("Hive Started");
    }
  } catch (e) {
    customPrint("$e");
    if (kDebugMode) {
      print("Hive Failed");
    }
  }
}

//ancy, pass-1122
