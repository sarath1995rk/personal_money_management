import 'package:hive/hive.dart';
import 'package:personal_money_management_app/models/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel extends HiveObject {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CategoryType type;
  @HiveField(4)
  final CategoryModel category;

  TransactionModel(
      this.purpose, this.amount, this.date, this.type, this.category);

  @override
  String toString() {
    return 'TransactionModel{purpose: $purpose, amount: $amount, date: $date, type: $type, category: $category}';
  }
}
