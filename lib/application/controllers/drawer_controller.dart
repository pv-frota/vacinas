import 'package:flutter_riverpod/flutter_riverpod.dart';

final drawerController = StateNotifierProvider<DrawerController>((_) {
  return DrawerController();
});

class DrawerController extends StateNotifier<int> {
  DrawerController() : super(0);
  void setCurrentTab(int index) {
    state = index;
  }
}
