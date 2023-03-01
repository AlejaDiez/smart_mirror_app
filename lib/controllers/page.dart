import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PageTransitionSwitcherController extends GetxController {
  PageTransitionSwitcherController(Map<int, Widget> pages) {
    _pages = pages;
  }

  int _index = 0;
  int _oldIndex = 0;
  late final Map<int, Widget> _pages;

  int get index => _index;

  Widget get page => _pages[_index] ?? const SizedBox.shrink();

  bool get isReverse => _oldIndex > _index;

  void changePage(int index) {
    if (!_pages.containsKey(index)) {
      throw Exception("There is no page with the following index: $index");
    }

    _oldIndex = _index;
    _index = index;
    update();
  }

  bool isSelected(int index) => index == _index;
}