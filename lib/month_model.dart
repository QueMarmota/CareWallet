import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'category_model.dart';

class MonthModel {
  List<CategoryModel> categories;
  String name;
  double total;
  MonthModel({
    this.categories,
    this.name,
    this.total,
  });

  MonthModel copyWith({
    List<CategoryModel> categories,
    String name,
    double total,
  }) {
    return MonthModel(
      categories: categories ?? this.categories,
      name: name ?? this.name,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categories': categories?.map((x) => x?.toMap())?.toList(),
      'name': name,
      'total': total,
    };
  }

  static MonthModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MonthModel(
      categories: List<CategoryModel>.from(
          map['categories']?.map((x) => CategoryModel.fromMap(x))),
      name: map['name'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  static MonthModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'MonthModel(categories: $categories, name: $name, total: $total)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MonthModel &&
        listEquals(o.categories, categories) &&
        o.name == name &&
        o.total == total;
  }

  getTotalOfCurrentMonth() {
    double temp = 0;
    categories.forEach((element) {
      temp += element.total;
    });
    return temp;
  }

  @override
  int get hashCode => categories.hashCode ^ name.hashCode ^ total.hashCode;
}
