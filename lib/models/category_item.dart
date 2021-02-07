import 'package:flutter/cupertino.dart';

class CategoryItem {
  CategoryItem({
    this.title,
    this.color,
    this.colorCode,
    this.projectCode,
  });
  final String title;
  final String colorCode;
  final Color color;
  final String projectCode;
}
