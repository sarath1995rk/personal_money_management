import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:personal_money_management_app/models/category_model.dart';

const CATEGORY_DB_NAME = 'category_db';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getAllCategories();

  Future<void> insertCategory(CategoryModel model);

  Future<void> deleteCategory(int id);
}

class CategoryDb implements CategoryDbFunctions {
  CategoryDb._internal();

  static CategoryDb instance = CategoryDb._internal();
  factory CategoryDb() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListNotifier =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel model) async {
    final _categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDb.add(model);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final _categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDb.values.toList();
  }

  Future<void> refreshUI() async {
    final _allCategories = await getAllCategories();
    incomeCategoryListNotifier.value.clear();
    expenseCategoryListNotifier.value.clear();
    await Future.forEach(_allCategories, (CategoryModel cat) {
      if (cat.type == CategoryType.income) {
        incomeCategoryListNotifier.value.add(cat);
      } else {
        expenseCategoryListNotifier.value.add(cat);
      }
    });
    expenseCategoryListNotifier.notifyListeners();
    incomeCategoryListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteCategory(int id) async {
    final _categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDb.delete(id);
    refreshUI();
  }
}
