import 'package:flutter/material.dart';
import 'package:personal_money_management_app/screens/home/home_screen.dart';

class BottomNavigationMoneyManagement extends StatelessWidget {
  const BottomNavigationMoneyManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndexNotifier,
      builder: (BuildContext ctx, int updated, Widget? _) {
        return BottomNavigationBar(
          selectedItemColor: Colors.purpleAccent,
          unselectedItemColor: Colors.grey,
          currentIndex: updated,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home), label: 'Transactions'),
            BottomNavigationBarItem(
                icon: const Icon(Icons.category), label: 'Categories')
          ],
          onTap: (newIndex) {
            HomeScreen.selectedIndexNotifier.value = newIndex;
          },
        );
      },
    );
  }
}
