import 'package:flutter/material.dart';

class PowerButtonComponent extends StatefulWidget {
  const PowerButtonComponent({
    required this.state,
    required this.onChanged
  });

  final bool state;
  final Function() onChanged;

  @override
  State<PowerButtonComponent> createState() => _PowerButtonComponentState();
}

class _PowerButtonComponentState extends State<PowerButtonComponent> {
  bool _expand = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onChanged,
      onPanDown: (_) => setState(() => _expand = true),
      onPanEnd: (_) => setState(() => _expand = false),
      onPanCancel: () => setState(() => _expand = false),
      child: AnimatedContainer(
        padding: const EdgeInsets.all(28.8),
        transform: Matrix4.identity()..scale(_expand ? 1.08 : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.state ? const Color(0xFF446DF6) : Colors.black,
          shape: BoxShape.circle
        ),
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOut,
        child: const Icon(
          IconData(0xF565, fontFamily: 'UIcons'),
          size: 22.4,
          color: Colors.white
        )
      )
    );
  }
}