import 'dart:math';
import 'package:flutter/material.dart';

class TabButtonComponent extends StatefulWidget {
  const TabButtonComponent({
    required this.expanded,
    required this.icon,
    required this.percentage,
    required this.color,
    this.data,
    this.suffix,
    this.onPressed
  }) : assert(percentage >= 0.0 && percentage <= 1.0);

  final bool expanded;
  final IconData icon;
  final double percentage;
  final Color color;
  final String? data;
  final String? suffix;
  final Function()? onPressed;

  @override
  State<TabButtonComponent> createState() => _TabButtonComponentState();
}

class _TabButtonComponentState extends State<TabButtonComponent> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 240))..value = widget.expanded ? 1.0 : 0.0;
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.24).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _colorAnimation = ColorTween(begin: widget.color.withOpacity(0.0), end: widget.color).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TabButtonComponent oldWidget) {
    if (oldWidget.expanded != widget.expanded) {
      _animationController.animateTo(widget.expanded ? 1.0 : 0.0);
    }
    if (oldWidget.color != widget.color) {
      _colorAnimation = ColorTween(begin: widget.color.withOpacity(0.0), end: widget.color).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) => ScaleTransition(
          scale: _scaleAnimation,
          child: child!
        ),
        child: Container(
          padding: const EdgeInsets.all(9.6),
          margin: const EdgeInsets.symmetric(horizontal: 14.0),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(100.0))
          ),
          child: Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints.tight(const Size.square(41.6)),
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (BuildContext context, _) => CustomPaint(painter: _BackgroundIconPainter(
                        percentage: widget.percentage,
                        color: _colorAnimation.value ?? widget.color.withOpacity(0.0)
                      ))
                    )),
                    Padding(
                      padding: const EdgeInsets.all(9.6),
                      child: Icon(
                        widget.icon,
                        size: 22.4,
                        color: Colors.black
                      )
                    )
                  ]
                )
              ),
              AnimatedSize(
                clipBehavior: Clip.none,
                alignment: Alignment.centerLeft,
                duration: _animationController.duration ?? Duration.zero,
                curve: Curves.easeOut,
                child: Visibility(
                  visible: widget.expanded && widget.data != null,
                  child: Container(
                    height: 41.6,
                    padding: const EdgeInsets.only(left: 12.8, right: 6.4),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(widget.data ?? "", style: Theme.of(context).textTheme.bodyLarge),
                        Visibility(
                          visible: widget.suffix != null,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6.4, bottom: 5.0),
                            child: Text(widget.suffix ?? "", style: Theme.of(context).textTheme.bodyMedium),
                          )
                        )
                      ]
                    )
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}

class _BackgroundIconPainter extends CustomPainter {
  _BackgroundIconPainter({
    required this.percentage,
    required this.color
  });

  final double percentage;
  final Color color; 

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    paint.color = color;
    paint.style = PaintingStyle.fill;
    canvas.drawArc(rect, -pi / 2, (2 * pi) * percentage, true, paint);
  }

  @override
  bool shouldRepaint(_BackgroundIconPainter oldDelegate) => true;
}