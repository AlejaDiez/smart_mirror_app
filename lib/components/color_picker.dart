import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerComponent extends StatefulWidget {
  const ColorPickerComponent({
    required this.color,
    required this.onChanged
  });

  final Color color;
  final Function(Color) onChanged;

  @override
  State<ColorPickerComponent> createState() => _ColorPickerComponentState();
}

class _ColorPickerComponentState extends State<ColorPickerComponent> {
  bool _expand = false;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        AllowMultipleVerticalDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<AllowMultipleVerticalDragGestureRecognizer>(
          () => AllowMultipleVerticalDragGestureRecognizer(),
          (AllowMultipleVerticalDragGestureRecognizer instance) {
            instance.onDown = (_) => setState(() => _expand = true);
            instance.onEnd = (_) => setState(() => _expand = false);
            instance.onCancel = () => setState(() => _expand = false);
          }
        )
      },
      child: AnimatedContainer(
        width: MediaQuery.of(context).size.shortestSide * 0.64,
        height: MediaQuery.of(context).size.shortestSide * 0.64,
        transform: Matrix4.identity()..scale(_expand ? 1.08 : 1.0),
        transformAlignment: Alignment.center,
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOut,
        child: ColorPickerArea(
          HSVColor.fromColor(widget.color),
          (HSVColor hsvColor) => widget.onChanged(hsvColor.toColor()),
          PaletteType.hueWheel
        )
      ),
    );
  }
}

class AllowMultipleVerticalDragGestureRecognizer extends VerticalDragGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}