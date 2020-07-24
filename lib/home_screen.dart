import 'package:carewallet/category_model.dart';
import 'package:carewallet/fl_chart_screen.dart';
import 'package:carewallet/months_model.dart';
import 'package:carewallet/sharedPreferences.dart';
import 'package:flutter/material.dart';

import 'month_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MonthsModel _monthsModel = MonthsModel();
  final prefs = new MiSharedPreferences();

  @override
  void initState() {
    super.initState();
    if (this.prefs.getInfo != null) {
      //get data from json
      var temp = _monthsModel.getData();
      _monthsModel.months = temp.months;
    } else {
      //crea la info
      //crear o cargar los menes en caso de que ya se crearon
      _monthsModel.months = [
        MonthModel(name: "Enero", total: 0, categories: List<CategoryModel>()),
        MonthModel(
            name: "Febrero", total: 0, categories: List<CategoryModel>()),
        MonthModel(name: "Marzo", total: 0, categories: List<CategoryModel>()),
        MonthModel(name: "Abril", total: 0, categories: List<CategoryModel>()),
        MonthModel(name: "Mayo", total: 0, categories: List<CategoryModel>()),
        MonthModel(name: "Junio", total: 0, categories: List<CategoryModel>()),
        MonthModel(name: "Julio", total: 0, categories: List<CategoryModel>()),
        MonthModel(name: "Agosto", total: 0, categories: List<CategoryModel>()),
        MonthModel(
            name: "Septiembre", total: 0, categories: List<CategoryModel>()),
        MonthModel(
            name: "Octubre", total: 0, categories: List<CategoryModel>()),
        MonthModel(
            name: "Noviembre", total: 0, categories: List<CategoryModel>()),
        MonthModel(
            name: "Diciembre", total: 0, categories: List<CategoryModel>()),
      ];
      _monthsModel.save(_monthsModel);
      // var temp = MonthsModel(months: _monthsModel.months);
      // //guardar
      // this.prefs.saveInfo = temp.toJson();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //meses
              Container(height: 50, child: Text('Lista de Meses')),
              //lista de meses
              Container(
                width: 300,
                height: 400,
                child: ListView.builder(
                  itemCount: _monthsModel.months.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      isThreeLine: true,
                      dense: true,
                      title: Text('${_monthsModel.months[index].name}'),
                      subtitle: Text(
                          'Total gastado: ${_monthsModel.months[index].getTotalOfCurrentMonth()}\$'),
                      trailing: IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PieChartSample2(
                                          data: _monthsModel,
                                          categoriesList: _monthsModel
                                              .months[index].categories,
                                          currentMont:
                                              _monthsModel.months[index],
                                        ))).then((value) {
                              setState(() {});
                            });
                          }),
                    );
                  },
                ),
              ),
              //boton resetear meses
            ],
          ),
        ),
      ),
    );
  }
}
