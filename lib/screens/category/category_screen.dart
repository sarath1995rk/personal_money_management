import 'package:flutter/material.dart';
import 'package:personal_money_management_app/dbFunctions/categoryDb.dart';
import 'package:personal_money_management_app/screens/category/expense_category_list.dart';
import 'package:personal_money_management_app/screens/category/income_category_list.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreshUI().then((value) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(
              text: 'Income',
            ),
            Tab(
              text: 'Expense',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
              controller: _tabController,
              children: [IncomeCategoryList(), ExpenseCategoryList()]),
        )
      ],
    );
  }
}
