import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_mirror_app/models/smart_mirror.dart';

class SmartMirrorController extends GetxController {
  SmartMirrorController(this.preferences) {
    if (preferences.containsKey("colors")) {
      List<String>? colors = preferences.getStringList("colors");

      colors?.forEach((String color) => _colors.add(Color(int.parse(color, radix: 16))));
      update(["colors"]);
    }
  }

  final SharedPreferences preferences;
  final SmartMirrorModel? _smartMirror = SmartMirrorModel("1.0.0", false, 0.8, Color(0xFFFFFFFF));
  final List<Color> _colors = <Color>[];

  String get version => _smartMirror?.version ?? "";

  bool get state => _smartMirror?.state ?? false;

  double get brightness => _smartMirror?.brightness ?? 0.0;


  Color get color => _smartMirror?.color ?? const Color(0xFFFFFFFF);

  int get colorsLength => _colors.length;

  Color getColor(int index) => _colors[index];

  void toggle() {
    if (_smartMirror != null) {
      _smartMirror!.state = !_smartMirror!.state;
      update(["state"]);
    }
  }

  void setBrightness(double value) {
    if (_smartMirror != null) {
      _smartMirror!.brightness = value;
      update(["brightness"]);
    }
  }

  void setColor(Color color) {
    if (_smartMirror != null) {
      _smartMirror!.color = color;
      update(["color"]);
    }
  }

  void setColorFromColors(int index) {
    if (_smartMirror != null) {
      _smartMirror!.color = _colors[index];
      update(["color"]);
    }
  }

  void addColor(Color color) {
    // Update colors list
    _colors.add(color);
    // Save in storage
    _saveColorsInStorage();
  }

  void addCurrentColor() {
    if (_smartMirror != null) {
      // Update colors list
      _colors.add(_smartMirror!.color);
      update(["colors"]);
      // Save in storage
      _saveColorsInStorage();
    }
  }

  void removeColor(int index) {
    // Update colors list
    _colors.removeAt(index);
    update(["colors"]);
    // Save in storage
    _saveColorsInStorage();
  }

  void _saveColorsInStorage() {
    final List<String> colors = [];

    _colors.forEach((Color color) => colors.add(color.value.toRadixString(16)));
    preferences.setStringList("colors", colors);
  }
}