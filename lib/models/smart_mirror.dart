import 'dart:ui';

class SmartMirrorModel {
  SmartMirrorModel(String version, this.state, this.brightness, this.color) 
    : assert(brightness >= 0.0 && brightness <= 1.0, "Brightness must be between values 0.0 and 1.0") {
      _version = version;
    }

  late final String _version;
  bool state;
  double brightness;
  Color color;
  
  String get version => _version;
}