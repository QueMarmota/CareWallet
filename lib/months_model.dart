import 'dart:convert';

import 'package:carewallet/sharedPreferences.dart';
import 'package:flutter/foundation.dart';

import 'package:carewallet/month_model.dart';

//esta clase es la cual va fungir como base de datos debido a que se hace lo siguiente
//se crearon clases que envuelven digamos toda la informacion que necesita la app , clases como
//montsModel , monthModel,category,etc
//monthsModel engloba a todas las demas , eventualmente esta clase padre se codifica a json
//y se guarda con sharepreferences,de esa manera guardo la disque "base de datos y sus registros" en una cadena
//de tipo json que hago decode(read) cada que inicia la app y hago encode(save) cada que quiera guardar algun dato

class MonthsModel {
  final prefs = MiSharedPreferences();

  List<MonthModel> months;
  MonthsModel({
    this.months,
  });

  getData() {
    print(this.prefs.getInfo.toString());
    return MonthsModel.fromJson(this.prefs.getInfo.toString());
  }

  save(MonthsModel _monthsModel) {
    var temp = MonthsModel(months: _monthsModel.months);
    //guardar
    this.prefs.saveInfo = temp.toJson();
  }

  MonthsModel copyWith({
    List<MonthModel> months,
  }) {
    return MonthsModel(
      months: months ?? this.months,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'months': months?.map((x) => x?.toMap())?.toList(),
    };
  }

  static MonthsModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MonthsModel(
      months: List<MonthModel>.from(
          map['months']?.map((x) => MonthModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static MonthsModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'MonthsModel(months: $months)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MonthsModel && listEquals(o.months, months);
  }

  @override
  int get hashCode => months.hashCode;
}
