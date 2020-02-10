
import 'package:flutter/material.dart';
import 'package:tienda_virtual/modelo.dart';
import 'package:tienda_virtual/producto.dart';
import 'package:tienda_virtual/servicios.dart';

class PageBuscar extends StatefulWidget {
  final Cliente cliente;

  const PageBuscar({Key key, this.cliente}) : super(key: key);

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState(this.cliente);



}

class _FavoriteWidgetState extends State<PageBuscar> {
  final Cliente cliente;
  List<Producto> _productos = List<Producto>();
  List<Producto> _productoDisplay = List<Producto>();

  @override
  void initState(){
    listarProducto().then((onValue){
      setState(() {
        _productos.addAll(onValue);
        _productoDisplay = _productos;
      });
    });
    super.initState();
  }

  _FavoriteWidgetState(this.cliente);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Buscar"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return index == 0 ? _serchBar() : ListTile(

            leading: CircleAvatar(
              backgroundImage: _productoDisplay[index-1].imagen !=null ? NetworkImage(_productoDisplay[index-1].imagen): NetworkImage("https://image.flaticon.com/icons/png/512/107/107831.png"),
              //backgroundImage: NetworkImage(producto.imagen),
            ),

            title: Text(
              _productoDisplay[index-1].nombre,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,// : Colors.red
              ),

            ),
            subtitle: Text(
              '\$'+_productoDisplay[index-1].precio.toString(),//: '\$'+producto.precio.toString()+" No hay suficiente Stock",
              style: TextStyle(
                color: Colors.green,
              ),
              maxLines: 1,
            ),

          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageProducto(producto: _productoDisplay[index-1],cliente: cliente,),
              ),
            );
          },
          );
        },
        itemCount: _productoDisplay.length + 1,
      ),

    );
  }
  _serchBar(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: "Buscar"),
        onChanged: (text){
          text = text.toString();
          setState(() {
            _productoDisplay = _productos.where((producto){
              var noteTitle = producto.nombre.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }


}