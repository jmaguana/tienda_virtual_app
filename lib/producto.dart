import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tienda_virtual/modelo.dart';
import 'package:tienda_virtual/servicios.dart';
import 'package:toast/toast.dart';


class PageProducto extends StatefulWidget {
  final Producto producto;
  final Cliente cliente;

  const PageProducto({Key key, this.producto, this.cliente}) : super(key: key);

  @override
    _FavoriteWidgetState createState() => _FavoriteWidgetState(producto, cliente);


}

class _FavoriteWidgetState extends State<PageProducto> {
  final Producto producto;
  final Cliente cliente;

  bool isFavorite = true;
  int _numeroProductos = 1;


  _FavoriteWidgetState(this.producto, this.cliente);

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(

        title: Text(producto.nombre),
      ),
      body: ListView(
        children: <Widget>[
          new Image.network(
            producto.imagen,
            height: 240,
            width: 600,
            fit: BoxFit.cover,
          ),
          titleSection(context),
          buttonSection(context),
          textSection(context),
          ],
        ));

  }


  Widget titleSection(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    producto.nombre,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '\$ ' + producto.precio.toString(),
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.favorite,
            color: Colors.red[500],
          ),
          Text(producto.votos.toString()),
        ],
      ),
    );
  }

  Widget textSection(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        producto.descripcion,
        softWrap: true,
      ),
    );
  }

  static Column _buildButtonColumn(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.indigo),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.indigo,
            ),
          ),
        ),
      ],
    );
  }

  Widget buttonSection(BuildContext context) {

    return Container(

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Material(
              child: InkWell(
                onTap: () {

                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  print('Me gusta');
                },
                child: isFavorite ? _buildButtonColumn(Icons.favorite_border, 'ME GUSTA'): _buildButtonColumn(Icons.favorite, 'ME GUSTA'),
              )),
          new Material(
              child: InkWell(
                onTap: () {

                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      child: new CupertinoAlertDialog(

                        title: new Column(

                          children: <Widget>[
                            new Text(
                              "Agregar a Carrito",
                              style: TextStyle(fontSize: 20),
                            ),

                            new Text(
                                producto.nombre,
                              style: TextStyle(fontSize: 10),
                            ),
                            new NumberPicker.horizontal(
                                initialValue: _numeroProductos,
                                minValue: 1,
                                maxValue: 10,
                                highlightSelectedValue: true,
                                onChanged: (newValue) => setState((){_numeroProductos = newValue;print(newValue);}),//(newValue) =>  _numeroProductos = newValue,//setState(() => print("")),
                            ),
                            new Icon(
                              Icons.add_shopping_cart,
                              color: Colors.indigo,
                            ),
                          ],
                        ),

                        actions: <Widget>[
                          new FlatButton(
                            onPressed: () {

                              agregarCarrito(_numeroProductos, producto.codigo, cliente.codigo);
                              print(_numeroProductos);
                              Toast.show(
                                  "Se agregó "+producto.nombre+" al carrito.", context,
                                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                              Navigator.of(context).pop();
                            },
                            child: new Text(
                              "Agregar",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                          new FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: new Text(
                                "cacelar",
                                style: TextStyle(color: Colors.white70),
                              ))
                        ],
                      ));
                },
                child:
                _buildButtonColumn(Icons.add_shopping_cart, 'AGREGAR CARRITO'),
              )),
          new Material(
              child: InkWell(
                onTap: () {
                  print('compartir');
                },
                child: _buildButtonColumn(Icons.share, 'COMPARTIR'),
              )),
        ],
      ),
    );
  }
}
/*
class MyDialogContent extends StatefulWidget {
  final Producto producto;
  final Cliente cliente;

  const MyDialogContent({Key key, this.producto, this.cliente}) : super(key: key);

  @override
  _MyDialogContentState createState() => _MyDialogContentState(producto, cliente);

}

class _MyDialogContentState extends State<MyDialogContent>{
  final Producto producto;
  final Cliente cliente;

  _MyDialogContentState(this.producto, this.cliente);
  @override
  Widget build(BuildContext context) {
    return Center();
  }

}*/