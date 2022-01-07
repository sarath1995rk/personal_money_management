import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_money_management_app/dbFunctions/categoryDb.dart';
import 'package:personal_money_management_app/dbFunctions/transactionDb.dart';
import 'package:personal_money_management_app/models/category_model.dart';
import 'package:personal_money_management_app/models/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refreshUITransaction();
    CategoryDb.instance.refreshUI();
    return ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionListNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
          return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemBuilder: (xtx, index) {
                final val = newList[index];
                return Card(
                  elevation: 0,
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 50,
                        backgroundColor: val.type == CategoryType.income
                            ? Colors.green
                            : Colors.red,
                        child: Text(
                          parseDate(val.date),
                          textAlign: TextAlign.center,
                        )),
                    title: Text('Rs ${val.amount}'),
                    subtitle: Text(val.category.name),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: newList.length);
        });
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last} \n ${_splitedDate.first}';
  }
}
