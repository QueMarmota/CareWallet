import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MiSharedPreferences {
  //Singleton
  static final MiSharedPreferences _instancia =
      new MiSharedPreferences._internal();

  factory MiSharedPreferences() {
    return _instancia;
  }

  MiSharedPreferences._internal();
  //end singleton
  SharedPreferences _prefs;

  //Instanciate prefs
  initprefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get getInfo {
    if (_prefs.getString('info') != null) {
      return json.decode(_prefs.getString('info'));
    }
    return null;
  }

  set saveInfo(value) {
    _prefs.setString('info', json.encode(value));
  }
}
