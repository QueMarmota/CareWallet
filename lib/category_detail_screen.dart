import 'package:carewallet/category_detail_model.dart';
import 'package:carewallet/month_model.dart';
import 'package:carewallet/months_model.dart';
import 'package:flutter/material.dart';

class CategoryDetailScreen extends StatefulWidget {
  final MonthsModel data;
  final String categoryTitle;
  final List<CategoryDetailModel> detailCategories;
  final MonthModel currentMonth;
  CategoryDetailScreen(
      {Key key,
      this.categoryTitle,
      @required this.detailCategories,
      @required this.data,
      @required this.currentMonth})
      : super(key: key);

  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  //debe cargar la lista de la data base , para este caso sera dump data
  TextEditingController _controllerValue = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  double _value;
  String _description;
  double _total;
  FocusNode _focusValue = FocusNode();
  FocusNode _focusDescription = FocusNode();

  @override
  void initState() {
    super.initState();
    //todo cargar desde database
    // widget.detailCategories = [
    //   CategoryDetailModel(
    //       value: 100, description: "Unas donas", date: DateTime.now()),
    //   CategoryDetailModel(
    //       value: 100, description: "Unas donas", date: DateTime.now()),
    //   CategoryDetailModel(
    //       value: 100, description: "Unas donas", date: DateTime.now()),
    // ];
  }

  addProduct() {
    if (_description?.isNotEmpty != null &&
        _value.toString()?.isNotEmpty != null) {
      widget.detailCategories.add(
        CategoryDetailModel(
            value: _value, description: _description, date: DateTime.now()),
      );
      _controllerDescription.clear();
      _controllerValue.clear();
      widget.currentMonth.total = getTotal();
      widget.data.save(widget.data);
      setState(() {});
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  getTotal() {
    if (widget.detailCategories?.isNotEmpty != null) {
      _total = 0;
      widget.detailCategories.forEach((element) {
        _total += element.value;
      });
      return _total;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Detalle'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: Text(widget.categoryTitle)),
              Container(
                  height: 250,
                  width: 300,
                  child: widget.detailCategories.length > 0
                      ? ListView.builder(
                          itemCount: widget.detailCategories?.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  '${widget.detailCategories[index].description}'),
                              subtitle: Text(
                                  '${widget.detailCategories[index].date.toString().substring(0, 10)}'),
                              leading: Text(
                                  '${widget.detailCategories[index].value}\$'),
                              trailing: IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  widget.detailCategories.removeAt(index);
                                  widget.data.save(widget.data);
                                  setState(() {});
                                },
                              ),
                              // Row(
                              //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   mainAxisSize: MainAxisSize.min,
                              //   children: <Widget>[
                              //     IconButton(
                              //       icon: Icon(Icons.remove),
                              //       onPressed: () {
                              //         widget.detailCategories.removeAt(index);
                              //         setState(() {});
                              //       },
                              //     ),
                              //       // IconButton(
                              //       //   icon: Icon(Icons.edit),
                              //       //   onPressed: () {},
                              //       // ),
                              //   ],
                              // ),
                            );
                          })
                      : Container(
                          alignment: Alignment.center,
                          child: Text('Sin Gastos'),
                        )),
              Container(
                alignment: Alignment.bottomCenter,
                // color: Colors.red,
                height: 50,
                child: Text('Total: ${getTotal()}\$'),
              ),
              //Cantidad
              Container(
                height: 80,
                width: 250,
                child: TextFormField(
                  controller: _controllerValue,
                  onChanged: (val) => _value = double.parse(val),
                  focusNode: _focusValue,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    _focusValue.unfocus();
                    FocusScope.of(context).requestFocus(_focusDescription);
                  },
                  style: TextStyle(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                        // fontFamily: 'Montserrat',
                        fontSize: 12,
                      ),
                      hintText: '1000',
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      labelText: 'Cantidad',
                      // errorStyle: TextStyle(fontFamily: 'Montserrat'),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        // fontFamily: 'Montserrat',
                      )),
                ),
              ),
              //descripcion
              Container(
                height: 80,
                width: 250,
                child: TextFormField(
                  controller: _controllerDescription,
                  onChanged: (val) => _description = (val),
                  focusNode: _focusDescription,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => addProduct(),
                  style: TextStyle(),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                        // fontFamily: 'Montserrat',
                        fontSize: 12,
                      ),
                      hintText: 'Donitas',
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      labelText: 'Descripcion',
                      // errorStyle: TextStyle(fontFamily: 'Montserrat'),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        // fontFamily: 'Montserrat',
                      )),
                ),
              ),
              //boton
              //Boton agregar
              RaisedButton(
                onPressed: addProduct,
                child: Text('Agregar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
