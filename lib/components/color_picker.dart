import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerComponent extends StatelessWidget {
  const ColorPickerComponent({
    required this.color,
    required this.onChanged
  });

  final Color color;
  final Function(Color) onChanged;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size.square(MediaQuery.of(context).size.shortestSide * 0.64)),
      child: ColorPickerArea(
        HSVColor.fromColor(color),
        (HSVColor hsvColor) => onChanged(hsvColor.toColor()),
        PaletteType.hueWheel
      )
    );
  }
}