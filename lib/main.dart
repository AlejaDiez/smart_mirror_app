import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/home.dart';

void main() => runApp(const SmartMirrorApp());

class SmartMirrorApp extends StatelessWidget {
  const SmartMirrorApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Mirror App',
      home: const HomeView(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFECECEC),
        hintColor: const Color(0x48000000),
        appBarTheme: const AppBarTheme(
          toolbarHeight: 80.0,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          titleSpacing: 32.0,
          centerTitle: false,
          titleTextStyle: TextStyle(fontFamily: 'Gilroy', fontSize: 32.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Colors.black),
          systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.light)
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Gilroy', fontSize: 25.6, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0xFF000000)),
          bodyMedium: TextStyle(fontFamily: 'Gilroy', fontSize: 16.0, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0xFF000000)),
          labelMedium: TextStyle(fontFamily: 'Gilroy', fontSize: 12.8, fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0xFF000000))
        )
      )
    );
  }
}