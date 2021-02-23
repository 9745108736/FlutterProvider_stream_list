import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:tp_connects/src/constents/colors.dart';
import 'package:tp_connects/src/getIt.dart';
import 'package:tp_connects/src/views/startScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    setup();
    runApp(new SixKicksApp());
  });
}

class SixKicksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abhijith Test',
      theme: _buildTheme(),
      home: StartScreen(),
      routes: {},
    );
  }
}

ThemeData _buildTheme() {
  final ThemeData base = ThemeData(fontFamily: 'SfProLight');
  return base.copyWith(
    accentColor: Colors.black87,
    primaryColor: MyColors.black.redC,
    scaffoldBackgroundColor: MyColors.black.redC,
    primaryIconTheme: base.iconTheme.copyWith(color: Colors.black),
    iconTheme: base.iconTheme.copyWith(color: Colors.black),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base.apply(
    displayColor: Colors.black87,
    bodyColor: Colors.black87,
  );
}
