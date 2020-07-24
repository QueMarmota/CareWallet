import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:carewallet/category_detail_model.dart';

class CategoryModel {
  double total;
  String title;
  Color color;
  List<CategoryDetailModel> details;
  CategoryModel({
    this.total,
    this.title,
    this.color,
    this.details,
  });

  CategoryModel copyWith({
    double total,
    String title,
    Color color,
    List<CategoryDetailModel> details,
  }) {
    return CategoryModel(
      total: total ?? this.total,
      title: title ?? this.title,
      color: color ?? this.color,
      details: details ?? this.details,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'title': title,
      'color': color?.value,
      'details': details?.map((x) => x?.toMap())?.toList(),
    };
  }

  static CategoryModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CategoryModel(
      total: map['total'],
      title: map['title'],
      color: Color(map['color']),
      details: List<CategoryDetailModel>.from(
          map['details']?.map((x) => CategoryDetailModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static CategoryModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryModel(total: $total, title: $title, color: $color, details: $details)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CategoryModel &&
        o.total == total &&
        o.title == title &&
        o.color == color &&
        listEquals(o.details, details);
  }

  @override
  int get hashCode {
    return total.hashCode ^ title.hashCode ^ color.hashCode ^ details.hashCode;
  }

  getTotalOfCurrentCategory() {
    if (details.isNotEmpty) {
      total = 0;
      details.forEach((element) {
        total += element.value;
      });
      return total;
    }
    //valor por default cuando no hay valores en la lista
    return 1.0;
  }
}
