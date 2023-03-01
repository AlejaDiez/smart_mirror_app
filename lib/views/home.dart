import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_mirror_app/components/color_picker.dart';
import 'package:smart_mirror_app/controllers/smart_mirror.dart';

import '../controllers/page.dart';
import '/components/color_button.dart';
import '/components/power_button.dart';
import '/components/brightness_slider.dart';
import '/components/tab_button.dart';

class HomeView extends StatelessWidget {
  const HomeView();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PageTransitionSwitcherController>(
      init: PageTransitionSwitcherController({
        0: _brightnessView(),
        1: _colorPickerView()
      }),
      builder: (PageTransitionSwitcherController pageController) => Scaffold(
        appBar: AppBar(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text("Smart Mirror"),
              Padding(
                padding: const EdgeInsets.only(left: 9.6, bottom: 5.0),
                child: GetBuilder<SmartMirrorController>(
                  id: "version",
                  builder: (SmartMirrorController smartMirror) => Text("v${smartMirror.version}", style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).hintColor))
                )
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
                  GetBuilder<SmartMirrorController>(
                    id: "brightness",
                    builder: (SmartMirrorController smartMirror) => TabButtonComponent(
                      expanded: pageController.isSelected(0),
                      icon: const IconData(0xF21C, fontFamily: 'UIcons'),
                      percentage: smartMirror.brightness,
                      color: const Color(0xFF53D8FB),
                      data: (smartMirror.brightness * 100).toInt().toString(),
                      suffix: "%",
                      onPressed: () => pageController.changePage(0)
                    )
                  ),
                  GetBuilder<SmartMirrorController>(
                    id: "color",
                    builder: (SmartMirrorController smartMirror) => TabButtonComponent(
                      expanded: pageController.isSelected(1),
                      icon: const IconData(0xF51F, fontFamily: 'UIcons'),
                      percentage: 1.0,
                      color: smartMirror.color,
                      onPressed: () => pageController.changePage(1)
                    )
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
                reverse: pageController.isReverse,
                transitionBuilder: (Widget child, Animation<double> primaryAnimation, Animation<double> secondaryAnimation) => SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  fillColor: Colors.transparent,
                  child: child
                ),
                child: pageController.page
              ),
              const Expanded(child: SizedBox()),
              GetBuilder<SmartMirrorController>(
                id: "state",
                builder: (SmartMirrorController smartMirror) => PowerButtonComponent(
                  state: smartMirror.state,
                  onChanged: smartMirror.toggle
                )
              ),
              const SizedBox(height: 16.0)
            ]
          )
        )
      ),
    );
  }

  Widget _brightnessView() {
    return Container(
      key: const Key('brightness'),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Center(
        child: GetBuilder<SmartMirrorController>(
          id: "brightness",
          autoRemove: false,
          builder: (SmartMirrorController smartMirror) => BrightnessSliderComponent(
            value: smartMirror.brightness,
            onChanged: smartMirror.setBrightness
          )
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
          GetBuilder<SmartMirrorController>(
            id: "color",
            autoRemove: false,
            builder: (SmartMirrorController smartMirror) => ColorPickerComponent(
              color: smartMirror.color,
              onChanged: smartMirror.setColor
            )
          ),
          const SizedBox(height: 64.0),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(height: 112.0),
            child: GetBuilder<SmartMirrorController>(
              id: "colors",
              autoRemove: false,
              builder: (SmartMirrorController smartMirror) => Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16.0,
                runSpacing: 16.0,
                children: List<Widget>.generate(smartMirror.colorsLength, (int index) => ColorButtonComponent(
                  color: smartMirror.getColor(index),
                  onSelect: () => smartMirror.setColorFromColors(index),
                  onRemove: () => smartMirror.removeColor(index)
                )) + (
                  smartMirror.colorsLength < 8
                  ? [
                      Builder(builder: (BuildContext context) => GestureDetector(
                        onTap: () => smartMirror.addCurrentColor(),
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
                      ))
                    ]
                  : []
                )
              )
            )
          )
        ]
      )
    );
  }
}

