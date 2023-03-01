import 'package:flutter/material.dart';

class ColorButtonComponent extends StatefulWidget {
  const ColorButtonComponent({
    required this.color,
    required this.onSelect,
    required this.onRemove,
    this.size = 48.0
  });

  final Color color;
  final Function() onSelect;
  final Function() onRemove;
  final double size;

  @override
  State<ColorButtonComponent> createState() => _ColorButtonComponentState();
}

class _ColorButtonComponentState extends State<ColorButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelect,
      onLongPress: widget.onRemove,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle
        )
      )
    );
  }
}