import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'screens/products_overview_screen.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductsOverviewScreen(),
      title: 'Shopping App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.white,
        fontFamily: 'Lato',
      ),
    );
  }
}
