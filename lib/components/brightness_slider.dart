import 'package:flutter/material.dart';

class BrightnessSliderComponent extends StatefulWidget {
  const BrightnessSliderComponent({
    required this.value,
    required this.onChanged
  }) : assert(value >= 0.0 && value <= 1.0);

  final double value;
  final Function(double) onChanged;

  @override
  State<BrightnessSliderComponent> createState() => _BrightnessSliderComponentState();
}

class _BrightnessSliderComponentState extends State<BrightnessSliderComponent> {
  double _position = 0.0;
  bool _expand = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (_) {
        _position = MediaQuery.of(context).size.height * 0.4 * widget.value;
        setState(() => _expand = true);
      },
      onVerticalDragUpdate: (DragUpdateDetails dragUpdateDetails) {
        _position -= dragUpdateDetails.delta.dy;
        _position = _position.clamp(0.0, MediaQuery.of(context).size.height * 0.4);
        widget.onChanged(_position / (MediaQuery.of(context).size.height * 0.4) );
      },
      onVerticalDragEnd: (_) => setState(() => _expand = false),
      onVerticalDragCancel: () => setState(() => _expand = false),
      child: AnimatedContainer(
        width: 80.0,
        height: MediaQuery.of(context).size.height * 0.4,
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.bottomCenter,
        transform: Matrix4.identity()..scale(_expand ? 1.08 : 1.0),
        transformAlignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(100.0))
        ),
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOut,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4 * widget.value,
          color: const Color(0xFF53D8FB)
        )
      )
    );
  }
}