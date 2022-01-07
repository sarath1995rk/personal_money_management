import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_money_management_app/models/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction_db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel model);

  Future<List<TransactionModel>> getAllTransactions();
}

class TransactionDb implements TransactionDbFunctions {
  TransactionDb._internal();

  static TransactionDb instance = TransactionDb._internal();
  factory TransactionDb() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);
  @override
  Future<void> addTransaction(TransactionModel model) async {
    print(model);
    final _transactionDb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactionDb.add(model);
    refreshUITransaction();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final _transactionDb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _transactionDb.values.toList();
  }

  Future<void> refreshUITransaction() async {
    final _allTransactions = await getAllTransactions();
    _allTransactions.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_allTransactions);

    // await Future.forEach(_allTransactions, (TransactionModel trans) {
    //   transactionListNotifier.value.add(trans);
    // });
    transactionListNotifier.notifyListeners();
  }
}
