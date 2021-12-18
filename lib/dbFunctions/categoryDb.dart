import 'package:hive/hive.dart';
import 'package:personal_money_management_app/models/category_model.dart';

const CATEGORY_DB_NAME = 'category_db';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getAllCategories();

  Future<void> insertCategory(CategoryModel model);
}

class CategoryDb implements CategoryDbFunctions {
  @override
  Future<void> insertCategory(CategoryModel model) async {
    final _categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDb.add(model);
    getAllCategories();
  }

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final _categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDb.values.toList();
  }
}
