import 'package:flutter/material.dart';

void main() => runApp(const SmartMirrorApp());

class SmartMirrorApp extends StatelessWidget {
  const SmartMirrorApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Mirror App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Smart Mirror App'),
        ),
        body: const Center(
          child: Text('Hello World')
        )
      )
    );
  }
}