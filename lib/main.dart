import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/products_overview_screen.dart';
import 'screens/product_detail_screen.dart';
import 'providers/products_provider.dart';
import 'providers/carts_provider.dart';
import './screens/cart_screen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartsProvider(),
        ),
      ],
      child: MaterialApp(
        home: ProductsOverviewScreen(),
        title: 'Shopping App',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.white,
          fontFamily: 'Lato',
        ),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartsScreen.routeName: (ctx) => CartsScreen(),
        },
      ),
    );
  }
}
