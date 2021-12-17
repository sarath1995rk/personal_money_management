import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(10),
        itemBuilder: (xtx, index) {
          return Card(
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(
                  radius: 50,
                  child: Text(
                    '12 \n Dec',
                    textAlign: TextAlign.center,
                  )),
              title: Text('amount spent'),
              subtitle: Text('category name'),
            ),
          );
        },
        separatorBuilder: (ctx, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: 10);
  }
}
