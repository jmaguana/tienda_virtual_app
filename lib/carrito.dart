import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_virtual/modelo.dart';
import 'package:tienda_virtual/servicios.dart';
import 'package:toast/toast.dart';

class PageCarrito extends StatefulWidget {
  final Cliente cliente;

  const PageCarrito({Key key, this.cliente}) : super(key: key);

  @override
  _pageCarrito createState() => _pageCarrito(cliente);

}

class _pageCarrito extends State<StatefulWidget> {
  final Cliente cliente;

  _pageCarrito(this.cliente);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.monetization_on,//credit_card,
              color: Colors.white,
            ),
            onPressed: (){
              generarCompra(cliente.codigo).then((onValue){
                print(onValue);
                if(onValue == "ok"){
                  Toast.show(
                      "Se realizó la compra exitosamente", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  Navigator.of(context).pop();
                }else{
                  Toast.show(
                      "El stock no es suficiente: "+onValue, context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                }


              });
              
              //Toast
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
           // new Text("Prueba"),
            new Expanded(
              child: new FutureBuilder<List<Producto>>(
        future: listarProductoCarrito(cliente.codigo),
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

                    onTap: (){
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        child: new CupertinoAlertDialog(
                          title: new Column(
                            children: <Widget>[
                              new Text("eliminar"),
                              new Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              )
                            ],

                          ),
                          content: new Text("nombre Producto"),
                          actions: <Widget>[
                            new FlatButton(
                              onPressed: (){
                                print("Eliminado");
                                eliminarCarrito(producto.codigo, cliente.codigo);
                                setState(() {

                                });
                                Navigator.of(context).pop();
                              },
                              child: new Text("eliminar"),
                            ),
                            new FlatButton(
                              child: new Text("cancelar"),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        )
                      );
                    },

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
          ],

        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete_forever),
      ),
    );
  }


}