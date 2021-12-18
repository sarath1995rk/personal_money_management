import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 2)
enum CategoryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense
}

@HiveType(typeId: 1)
class CategoryModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final CategoryType type;
  @HiveField(2)
  final bool isDeleted;

  CategoryModel(this.name, this.type, this.isDeleted);

  @override
  String toString() {
    return 'CategoryModel{name: $name, type: $type, isDeleted: $isDeleted}';
  }
}

//flutter pub run build_runner build --delete-conflicting-outputs
