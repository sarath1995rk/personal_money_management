import 'package:flutter/material.dart';
import 'package:personal_money_management_app/dbFunctions/categoryDb.dart';
import 'package:personal_money_management_app/models/category_model.dart';

class AddTransactionScreen extends StatefulWidget {
  static const routeName = '/add_transaction_screen';
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  DateTime? _selectedDate;
  CategoryType _selectedCategoryType = CategoryType.income;
  CategoryModel? _selectedCategoryModel;
  String? selectedCategoryText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(hintText: 'Purpose'),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Amount'),
            ),
            TextButton.icon(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(Duration(days: 30)),
                      lastDate: DateTime.now());
                  if (pickedDate == null) {
                    return;
                  } else {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(_selectedDate == null
                    ? 'select date'
                    : _selectedDate.toString())),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio<CategoryType>(
                      value: CategoryType.income,
                      groupValue: _selectedCategoryType,
                      onChanged: (newVal) {
                        setState(() {
                          _selectedCategoryType = newVal!;
                        });
                      },
                    ),
                    Text('Income')
                  ],
                ),
                Row(
                  children: [
                    Radio<CategoryType>(
                      value: CategoryType.expense,
                      groupValue: _selectedCategoryType,
                      onChanged: (newVal) {
                        setState(() {
                          _selectedCategoryType = newVal!;
                        });
                      },
                    ),
                    Text('Expense')
                  ],
                )
              ],
            ),
            DropdownButton(
              value: _selectedCategoryModel,
              hint: Text('Select Category'),
              items: _selectedCategoryType == CategoryType.income
                  ? CategoryDb.instance.incomeCategoryListNotifier.value
                      .map((e) {
                      return DropdownMenuItem(
                        child: Text(e.name),
                        value: e,
                      );
                    }).toList()
                  : CategoryDb.instance.expenseCategoryListNotifier.value
                      .map((e) {
                      return DropdownMenuItem(
                        child: Text(e.name),
                        value: e.key,
                      );
                    }).toList(),
              onChanged: (val) {
                setState(() {
                  _selectedCategoryModel = val as CategoryModel?;
                });
              },
            ),
            Center(
              child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check),
                  label: const Text('Submit')),
            )
          ],
        ),
      ),
    );
  }
}
