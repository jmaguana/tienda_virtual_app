
import 'package:flutter/material.dart';
import 'package:tienda_virtual/modelo.dart';
import 'package:tienda_virtual/servicios.dart';

class PageCompra extends StatelessWidget {
  final Cliente cliente;
  final Compra compra;

  const PageCompra({Key key, this.cliente, this.compra}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto de compra'),
      ),
      body: Center(
        child: FutureBuilder<List<Producto>>(
          future: listarProductosCompra(compra.codigo),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  var producto = snapshot.data[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: producto.imagen !=null ? NetworkImage(producto.imagen): NetworkImage("https://image.flaticon.com/icons/png/512/107/107831.png"),
                      //backgroundImage: NetworkImage(producto.imagen),
                    ),
                    title: Text(
                      producto.cantidad == 1 ? producto.nombre+": "+producto.cantidad.toString()+" unidad": producto.nombre+": "+producto.cantidad.toString()+" unidades",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54
                      ),

                    ),
                    subtitle: Text(
                      '\$'+producto.precio.toString(),
                      style: TextStyle(
                        color: Colors.green,
                      ),
                      maxLines: 1,
                    ),
                  );
                }
              );
            }else if(snapshot.hasError){
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          }
        ),
      ),

    );
  }

}