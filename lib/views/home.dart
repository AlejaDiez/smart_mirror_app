import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:smart_mirror_app/components/color_picker.dart';
import 'package:smart_mirror_app/models/smart_mirror.dart';

import '/components/power_button.dart';
import '../components/brightness_slider.dart';
import '/components/tab_button.dart';

class HomeView extends StatefulWidget {
  const HomeView();

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _index = 0;
  final SmartMirror _smartMirror = SmartMirror(
    version: "1.0.0",
    state: false,
    brightness: 0.6,
    color: "#FFFFFF",
    colors: [const Color(0xFFFFFF), const Color(0xFF0000)]
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text("Smart Mirror"),
            Padding(
              padding: const EdgeInsets.only(left: 9.6, bottom: 5.0),
              child: Text("v${_smartMirror.version}", style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).hintColor))
            )
          ]
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TabButtonComponent(
                  expanded: _index == 0,
                  icon: const IconData(0xF21C, fontFamily: 'UIcons'),
                  percentage: _smartMirror.brightness,
                  color: const Color(0xFF53D8FB),
                  data: (_smartMirror.brightness * 100).toInt().toString(),
                  suffix: "%",
                  onPressed: () => setState(() => _index = 0)
                ),
                TabButtonComponent(
                  expanded: _index == 1,
                  icon: const IconData(0xF51F, fontFamily: 'UIcons'),
                  percentage: 1.0,
                  color: _smartMirror.color,
                  onPressed: () => setState(() => _index = 1)
                )
              ]
            )
          )
        )
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            PageTransitionSwitcher(
              duration: const Duration(milliseconds: 240),
              reverse: _index == 0,
              transitionBuilder: (Widget child, Animation<double> primaryAnimation, Animation<double> secondaryAnimation) => SharedAxisTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                fillColor: Colors.transparent,
                child: child
              ),
              child: _index == 0
                ? _brightnessView()
                : _colorPickerView()
            ),
            const Expanded(child: SizedBox()),
            PowerButtonComponent(
              state: _smartMirror.state,
              onChanged: () => setState(() => _smartMirror.toggle())
            ),
            const SizedBox(height: 16.0)
          ]
        )
      )
    );
  }

  Widget _brightnessView() {
    return Container(
      key: const Key('brightness'),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Center(
        child: BrightnessSliderComponent(
          value: _smartMirror.brightness,
          onChanged: (double value) => setState(() => _smartMirror.setBrightness(value))
        )
      )
    );
  }

  Widget _colorPickerView() {
    return Container(
      key: const Key('color picker'),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ColorPickerComponent(
            color: _smartMirror.color,
            onChanged: (Color color) => setState(() => _smartMirror.setColor(color))
          ),
          const SizedBox(height: 64.0),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(height: 112.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16.0,
              runSpacing: 16.0,
              children: List<Widget>.generate(_smartMirror.getSizeOfColors(), (index) => GestureDetector(
                onTap: () => setState(() => _smartMirror.setColorFromList(index)),
                onLongPress: () => setState(() => _smartMirror.removeColor(index)),
                child: Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _smartMirror.getColor(index)
                  )
                )
              )) + (
                _smartMirror.getSizeOfColors() < 8
                  ? [
                    GestureDetector(
                      onTap: () => setState(() => _smartMirror.addCurrentColor()),
                      onLongPress: _smartMirror.getSizeOfColors() == 0
                        ? () => setState(() => _smartMirror.addColor(Colors.white))
                        : null,
                      child: Container(
                        width: 48.0,
                        height: 48.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).hintColor,
                            width: 1.8
                          )
                        ),
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context).hintColor
                        )
                      )
                    )
                  ]
                  : []
              )
            )
          )
        ]
      )
    );
  }
} 