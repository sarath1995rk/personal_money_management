import 'package:flutter/material.dart';
import 'package:personal_money_management_app/dbFunctions/categoryDb.dart';
import 'package:personal_money_management_app/dbFunctions/transactionDb.dart';
import 'package:personal_money_management_app/models/category_model.dart';
import 'package:personal_money_management_app/models/transaction_model.dart';

class AddTransactionScreen extends StatefulWidget {
  static const routeName = '/add_transaction_screen';
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  DateTime? _selectedDate;
  late CategoryType _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  String? _categoryId;
  final _purposeController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  void dispose() {
    _purposeController.clear();
    _amountController.clear();
    super.dispose();
  }

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
              controller: _purposeController,
              decoration: const InputDecoration(hintText: 'Purpose'),
            ),
            TextFormField(
              controller: _amountController,
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
                          _categoryId = null;
                          _selectedCategoryType = CategoryType.income;
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
                          _categoryId = null;
                          _selectedCategoryType = CategoryType.expense;
                        });
                      },
                    ),
                    Text('Expense')
                  ],
                )
              ],
            ),
            DropdownButton(
              value: _categoryId,
              hint: Text('Select Category'),
              items: (_selectedCategoryType == CategoryType.income
                      ? CategoryDb.instance.incomeCategoryListNotifier
                      : CategoryDb.instance.expenseCategoryListNotifier)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                  onTap: () {
                    _selectedCategoryModel = e;
                  },
                  child: Text(e.name),
                  value: e.key.toString(),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  print(val.toString());
                  _categoryId = val.toString();
                });
              },
            ),
            Center(
              child: ElevatedButton.icon(
                  onPressed: _addTransaction,
                  icon: const Icon(Icons.check),
                  label: const Text('Submit')),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _addTransaction() async {
    final purposeText = _purposeController.text;
    final amountText = _amountController.text;
    if (purposeText.isEmpty || amountText.isEmpty) {
      return;
    }
    if (_categoryId == null || _selectedDate == null) {
      return;
    }
    final parsedAmount = double.tryParse(amountText);
    if (parsedAmount == null || _selectedCategoryModel == null) {
      return;
    }

    final _model = TransactionModel(purposeText, parsedAmount, _selectedDate!,
        _selectedCategoryType, _selectedCategoryModel!);

    TransactionDb.instance.addTransaction(_model);
  }
}
