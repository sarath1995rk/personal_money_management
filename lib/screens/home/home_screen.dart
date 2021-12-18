import 'package:flutter/material.dart';
import 'package:personal_money_management_app/custom_paint_test/custom_screen.dart';
import 'package:personal_money_management_app/screens/category/category_add_popup.dart';
import 'package:personal_money_management_app/screens/category/category_screen.dart';
import 'package:personal_money_management_app/screens/home/widgets/bottomNavigationMoneyManagement.dart';
import 'package:personal_money_management_app/screens/transactions/transcation_screen.dart';

class HomeScreen extends StatelessWidget {
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = [TransactionScreen(), CategoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Money Manager'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => CustomScreen())),
              icon: const Icon(
                Icons.logout,
                color: Colors.white60,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
          } else {
            showCategoryAddPopup(context);
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavigationMoneyManagement(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (_, int index, __) {
            return _pages[index];
          },
        ),
      ),
    );
  }
}
