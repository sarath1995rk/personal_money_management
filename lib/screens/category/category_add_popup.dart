import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_money_management_app/dbFunctions/categoryDb.dart';
import 'package:personal_money_management_app/models/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final _controller = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('Add Category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Category name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RadioButton('Income', CategoryType.income),
                  RadioButton('Expense', CategoryType.expense)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    final name = _controller.text;
                    if (name.isEmpty) {
                      return;
                    }
                    final type = selectedCategoryNotifier.value;
                    CategoryModel val = CategoryModel(name, type, false);
                    CategoryDb.instance.insertCategory(val);
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Add')),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  RadioButton(this.title, this.type);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder: (ctx, CategoryType catType, __) {
              return Radio<CategoryType>(
                  value: type,
                  groupValue: catType,
                  onChanged: (val) {
                    print(val);
                    if (val == null) {
                      return;
                    } else {
                      selectedCategoryNotifier.value = val;
                    }
                  });
            }),
        Text(title)
      ],
    );
  }
}
