import 'dart:ui';

class SmartMirror {
  SmartMirror({
    required this.version,
    required this.state,
    required double brightness,
    required String color,
    required List<Color> colors
  }) {
    _brightness = brightness;
    setColor(color);
    _colors = colors;
  }

  final String version;
  bool state;
  late double _brightness;
  late Color _color;
  late final List<Color> _colors;
  
  double get brightness => _brightness;

  Color get color => _color;

  int get colorInt => _color.value;

  String get colorString => "#FF${colorInt.toRadixString(16)}";

  Color getColor(int index) => _colors[index].withOpacity(1.0);

  int getSizeOfColors() => _colors.length;

  void toggle() {
    state = !state;
  }

  void setBrightness(double brightness) {
    if (brightness > 1.0 || brightness < 0.0) {
      throw Exception("The brightness must be between values 0.0 and 1.0");
    }

    _brightness = brightness;
  }

  void setColor(dynamic color) {
    if (color is Color) {
      _color = color.withOpacity(1.0);
    } else if (color is int) {
      if (color > 0xFFFFFF || color < 0x000000) {
        throw Exception("The color must be between values 0xFFFFFF and 0x000000");
      }

      _color = Color(color).withOpacity(1.0);
    } else if (color is String) {
      _color = Color(int.parse(color.replaceFirst('#', ""), radix: 16)).withOpacity(1.0);
    } else {
      throw TypeError();
    }
  }

  void setColorFromList(int index) {
    if (index >= _colors.length && index < 0) {
      throw Exception("The index must be between values 0 and ${_colors.length - 1}");
    }

    setColor(_colors[index]);
  }

  void addColor(Color color) {
    _colors.add(color.withOpacity(1.0));
  }

  void addCurrentColor() {
    _colors.add(_color.withOpacity(1.0));
  }

  void removeColor(int index) {
    _colors.removeAt(index);
  }
}