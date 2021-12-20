import 'package:flutter/material.dart';
import 'package:personal_money_management_app/dbFunctions/categoryDb.dart';
import 'package:personal_money_management_app/models/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb.instance.incomeCategoryListNotifier,
        builder: (BuildContext ctx, List<CategoryModel> list, Widget? _) {
          return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemBuilder: (ctx, index) {
                return Card(
                  child: ListTile(
                    title: Text(list[index].name),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () =>
                          CategoryDb.instance.deleteCategory(list[index].key),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: list.length);
        });
  }
}
