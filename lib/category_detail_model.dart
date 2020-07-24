import 'dart:convert';

class CategoryDetailModel {
  double value;
  String description;
  DateTime date;
  CategoryDetailModel({
    this.value,
    this.description,
    this.date,
  });

  CategoryDetailModel copyWith({
    double value,
    String description,
    DateTime date,
  }) {
    return CategoryDetailModel(
      value: value ?? this.value,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'description': description,
      'date': date?.millisecondsSinceEpoch,
    };
  }

  static CategoryDetailModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CategoryDetailModel(
      value: map['value'],
      description: map['description'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  static CategoryDetailModel fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() =>
      'CategoryDetailModel(value: $value, description: $description, date: $date)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CategoryDetailModel &&
        o.value == value &&
        o.description == description &&
        o.date == date;
  }

  @override
  int get hashCode => value.hashCode ^ description.hashCode ^ date.hashCode;
}
