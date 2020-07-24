import 'dart:math' as math;

import 'package:carewallet/category_detail_model.dart';
import 'package:carewallet/month_model.dart';
import 'package:carewallet/months_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:carewallet/category_detail_screen.dart';
import 'package:carewallet/category_model.dart';
import 'package:flutter/rendering.dart';

import 'fl_indicator.dart';

class PieChartSample2 extends StatefulWidget {
  final List<CategoryModel> categoriesList;
  final MonthModel currentMont;
  final MonthsModel data;

  PieChartSample2({
    Key key,
    @required this.categoriesList,
    @required this.data,
    @required this.currentMont,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex;
  //focus for textfields
  FocusNode _focusCategory = FocusNode();
  FocusNode _focusValue = FocusNode();
  String _category;
  double _value;

  TextEditingController _controllerCategory = TextEditingController();
  TextEditingController _controllerValue = TextEditingController();
  List<Color> _listColorsBlue = [
    Colors.blue[50],
    Colors.blue[100],
    Colors.blue[200],
    Colors.blue[300],
    Colors.blue[400],
    Colors.blue,
    Colors.blue[600],
    Colors.blue[700],
    Colors.blue[800],
    Colors.blue[900],
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //todo dump data
  }

  Color getRandomColor() => Color(math.Random().nextInt(0xffffffff));

  _addCategory() {
    if (_category?.isNotEmpty != null) {
      setState(() {
        widget.categoriesList.add(CategoryModel(
            total: 1,
            title: _category,
            color: getRandomColor(),
            details: List<CategoryDetailModel>()));
        //total por default 1
        _category = "";
        _value = 0;
        _controllerCategory.clear();
        _controllerValue.clear();
        //save on the "database"

        print("GUARDAR: " + widget.data.toString());
        widget.data.save(widget.data);
        //leer por prueba
        print(widget.data.getData().toString());
        FocusScope.of(context).requestFocus(FocusNode());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(''),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: <Widget>[
              //Mes
              Container(
                // color: Colors.pink,
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.10,
                child: Text(
                  'Mes de ${widget.currentMont.name}',
                  style: TextStyle(fontSize: 35),
                ),
              ),
              //canvas dentro va el chart y labels
              Container(
                // color: Colors.red,
                height: 370,
                width: double.infinity,
                // aspectRatio: 1.5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //chart
                    Container(
                      child: PieChart(
                        PieChartData(
                            pieTouchData:
                                PieTouchData(touchCallback: (pieTouchResponse) {
                              setState(() {
                                //Este codigo evalua cuanto tiempo esta tap pressed para seguir haciendo la animacion
                                if (pieTouchResponse.touchInput
                                        is FlLongPressEnd ||
                                    pieTouchResponse.touchInput is FlPanEnd) {
                                  //cuando se deja de precionar se activa este para regresar al estado normal
                                  // touchedIndex = -1;
                                } else {
                                  //aqui entra por primera vez
                                  touchedIndex =
                                      pieTouchResponse.touchedSectionIndex;
                                  //todo navegar al detalle y al regresar en pop, restablece el index
                                  if (touchedIndex != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryDetailScreen(
                                                  currentMonth:
                                                      widget.currentMont,
                                                  data: widget.data,
                                                  detailCategories: widget
                                                      .categoriesList[
                                                          touchedIndex]
                                                      .details,
                                                  categoryTitle: widget
                                                      .categoriesList[
                                                          touchedIndex]
                                                      .title,
                                                ))).then((value) {
                                      //cuando sea pop , pone el touchedIndex en -1 para quitar la animacion
                                      touchedIndex = -1;
                                      setState(() {});
                                    });
                                  }
                                }
                              });
                            }),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 50,
                            //muestra valores generados de la informacion creada
                            sections: showingSections()),
                      ),
                    ),
                    //lista de indicator(labels)
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        // color: Colors.blue,
                        width: double.infinity,
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          // mainAxisSize: MainAxisSize.min,
                          // mainAxisAlignment: MainAxisAlignment.end,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ...widget.categoriesList.map((item) {
                              //indicator es el label que se muestra abajo a la derecha
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CategoryDetailScreen(
                                                currentMonth:
                                                    widget.currentMont,
                                                data: widget.data,
                                                detailCategories: item.details,
                                                categoryTitle: item.title,
                                              ))).then((value) {
                                    setState(() {});
                                  });
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      height: 30,
                                      child: Indicator(
                                        color: item.color,
                                        text: '${item.title}',
                                        isSquare: true,
                                      ),
                                    ),
                                    Container(
                                      // width: 20,
                                      child: IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            widget.categoriesList.remove(item);
                                            widget.data.save(widget.data);
                                            setState(() {});
                                          }),
                                    )
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    //total of the month
                    Text('Total acumulado: ' +
                        widget.currentMont.getTotalOfCurrentMonth().toString() +
                        '\$'),
                  ],
                ),
              ),
              //Nombre categoria
              Container(
                height: 70,
                width: 250,
                child: TextFormField(
                  controller: _controllerCategory,
                  focusNode: _focusCategory,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _addCategory(),
                  // textInputAction: TextInputAction.next,
                  // onFieldSubmitted: (_) {
                  //   _focusCategory.unfocus();
                  //   FocusScope.of(context).requestFocus(_focusValue);
                  // },
                  onChanged: (val) => _category = val,
                  style: TextStyle(),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                        // fontFamily: 'Montserrat',
                        fontSize: 12,
                      ),
                      hintText: 'Servicios',
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      labelText: 'Agrega Nueva Categoria',
                      // errorStyle: TextStyle(fontFamily: 'Montserrat'),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        // fontFamily: 'Montserrat',
                      )),
                ),
              ),
              //Cantidad inicial
              // Container(
              //   height: 80,
              //   width: 250,
              //   child: TextFormField(
              //     controller: _controllerValue,
              //     onChanged: (val) => _value = double.parse(val),
              //     focusNode: _focusValue,
              //     textInputAction: TextInputAction.done,
              //     onFieldSubmitted: (_) => _addCategory(),
              //     style: TextStyle(),
              //     keyboardType: TextInputType.number,
              //     decoration: InputDecoration(
              //         hintStyle: TextStyle(
              //           // fontFamily: 'Montserrat',
              //           fontSize: 12,
              //         ),
              //         hintText: '1000',
              //         alignLabelWithHint: true,
              //         contentPadding: EdgeInsets.symmetric(vertical: 10),
              //         labelText: 'Cantidad Inicial',
              //         // errorStyle: TextStyle(fontFamily: 'Montserrat'),
              //         labelStyle: TextStyle(
              //           fontSize: 18,
              //           // fontFamily: 'Montserrat',
              //         )),
              //   ),
              // ),
              //Boton agregar
              RaisedButton(
                onPressed: _addCategory,
                child: Text('Agregar'),
              )
            ],
          )),
        ),
      ),
    );
  }

  //todo voy a tener que generar una lista con los datos previos como
  // value , title ,color y que apartir de esa lista se generen las piechart
  //genera los datos para el grafico
  List<PieChartSectionData> showingSections() {
    return List.generate(widget.categoriesList.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      return PieChartSectionData(
        color: widget.categoriesList[i].color,
        value: widget.categoriesList[i].total,
        //todo total debe ser el chingon
        title: widget.categoriesList[i].getTotalOfCurrentCategory() != 1.0
            ? widget.categoriesList[i].total.toString() + '\$'
            : '0.0\$',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.red),
      );

      // switch (i) {
      //   case 0:
      //     return PieChartSectionData(
      //       color: const Color(0xff0293ee),
      //       value: 40,
      //       title: '\$2500',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //           fontSize: fontSize,
      //           fontWeight: FontWeight.bold,
      //           color: const Color(0xffffffff)),
      //     );
      //   case 1:
      //     return PieChartSectionData(
      //       color: const Color(0xfff8b250),
      //       value: 30,
      //       title: '\$1500',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //           fontSize: fontSize,
      //           fontWeight: FontWeight.bold,
      //           color: const Color(0xffffffff)),
      //     );
      //   case 2:
      //     return PieChartSectionData(
      //       color: const Color(0xff845bef),
      //       value: 15,
      //       title: '\$500',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //           fontSize: fontSize,
      //           fontWeight: FontWeight.bold,
      //           color: const Color(0xffffffff)),
      //     );
      //   case 3:
      //     return PieChartSectionData(
      //       color: const Color(0xff13d38e),
      //       value: 15,
      //       title: '\$500',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //           fontSize: fontSize,
      //           fontWeight: FontWeight.bold,
      //           color: const Color(0xffffffff)),
      //     );
      //   default:
      //     return null;
      // }
    });
  }
}
