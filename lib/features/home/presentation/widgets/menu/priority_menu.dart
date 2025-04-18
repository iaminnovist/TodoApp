import 'package:flutter/material.dart';
import 'package:todotask/features/home/presentation/providers/home_provider.dart';

void showPriorityMenu(BuildContext context, HomeProvider controller) {
  final RenderBox renderBox = controller.flagKey.currentContext!.findRenderObject() as RenderBox;
  final Offset offset = renderBox.localToGlobal(Offset.zero);

  showMenu<String>(
    context: context,
    color: Colors.white,
    position: RelativeRect.fromLTRB(
      offset.dx,
      offset.dy - 200,
      offset.dx,
      offset.dy,
    ),
    items: [
      const PopupMenuItem<String>(
        value: 'High',
        child: Text('⚠️  High Priority', style: TextStyle(color: Color(0xffFF486A), fontSize: 18)),
      ),
      const PopupMenuDivider(),
      const PopupMenuItem<String>(
        value: 'Medium',
        child: Text('⏳  Medium Priority', style: TextStyle(color: Color(0xffED9611), fontSize: 18)),
      ),
      const PopupMenuDivider(),
      const PopupMenuItem<String>(
        value: 'Low',
        child: Text('✅  Low Priority', style: TextStyle(color: Color(0xff01AD01), fontSize: 18)),
      ),
    ],
  ).then((value) {
    if (value != null) {
      controller.selectedPriority = value;
      controller.notifyListeners();
    }
  });
}
