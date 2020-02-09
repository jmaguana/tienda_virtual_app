import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_virtual/compartidos.dart';
import 'package:tienda_virtual/modelo.dart';
import 'package:tienda_virtual/producto.dart';
import 'package:tienda_virtual/servicios.dart';
import 'package:tienda_virtual/carrito.dart';
import 'package:tienda_virtual/compras.dart';

import 'main.dart';


class PageInicio extends StatefulWidget {
  final Cliente cliente;

  const PageInicio({Key key, this.cliente}) : super(key: key);

  @override
  _PageInicio createState() => _PageInicio(cliente);

}

class _PageInicio extends State<PageInicio> {
  final Cliente cliente;

  _PageInicio(this.cliente){
    numeroCompartido(cliente.codigo).then((onValue){
      setState(() {
        notificaciones = onValue;
      });
    });
  }

  int notificaciones = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        title: Text(cliente.nombre),
        actions: <Widget>[

          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageCarrito(cliente: cliente,))
                );
              }
          ),
          IconButton(
              icon: Icon(
                Icons.history,
                color: Colors.white,
              ),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageCompras(cliente: cliente,))
                );
              }
          ),
         // myAppBarIcon(context,cliente,notificaciones),


          IconButton(
            color: Colors.white,
            onPressed: (){
              numeroCompartido(cliente.codigo).then((onValue){
                setState(() {
                  notificaciones = onValue;
                });
              });
              print("Compartidos");
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageCompartidos(cliente: cliente,))
              );
            },
            icon: Stack(
              children: [
                Icon(
                Icons.notifications,
                color: Colors.white,

                ),
                notificaciones != 0 ? Container(
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffc32c37),
                      border: Border.all(color: Colors.white, width: 1)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Center(
                        child: Text(
                          notificaciones < 10 ? notificaciones.toString():"+9", //_counter.toString(),
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                  ): Container(
                    child: Container(
                      width: 15,
                      height: 15,
                    )
                )
              ],
            ),
          ),

         IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: (){
                print("Compartidos");
                Route route = MaterialPageRoute(builder: (context)=> MyApp());
                Navigator.pushReplacement(context, route);
              }
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Producto>>(
          future: listarProducto(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (BuildContext context, int index){
                  var producto = snapshot.data[index];

                  return new GestureDetector(
                    child: new Card(
                        elevation: 1.0,
                        child: new Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            producto.imagen != null ? new Image.network(
                              producto.imagen,
                              height: 105.0,
                              width: 130.0,
                              fit: BoxFit.cover,
                            ): Image.network(
                              'http://revistazonalibre.com/images/noticias/2020Enero/23olx.JPG',
                              height: 105.0,
                              width: 130.0,
                              fit: BoxFit.cover,
                            ),

                            new Text(
                              //snapshot[index].data['nombre'],
                              producto.nombre,
                              maxLines: 1,

                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.indigo,
                              ),
                            ),
                            new Text(
                              producto.descripcion,
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 9.0,
                                color: Colors.black45,
                              ),
                            ),
                            new Text(
                              '\$'+producto.precio.toString(),
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ],
                        )
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageProducto(producto: producto,cliente: cliente,),
                        ),
                      );
                    },

                  );
                  ///
                },
              );
            }else if(snapshot.hasError){
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Widget myAppBarIcon(BuildContext context, Cliente cliente, int cantidad) {
  return IconButton(
    //width: 30,
   // height: 30,
    color: Colors.white,
    onPressed: (){
      numeroCompartido(cliente.codigo).then((onValue){
        //setState(() {
          cantidad = onValue;
       // });
      });
      print("Compartidos");
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PageCompartidos(cliente: cliente,))
      );
    },
    icon: Stack(

      children: [
        Icon(
          Icons.notifications,
          color: Colors.white,

          //size: 30,
        ),
        cantidad != 0 ? Container(
          //width: 30,
          //height: 30,
          //alignment: Alignment.topRight,
          //margin: EdgeInsets.only(top: 5),
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffc32c37),
                border: Border.all(color: Colors.white, width: 1)),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Center(
                child: Text(
                  cantidad < 10 ? cantidad.toString():"+9", //_counter.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
        ): Container(
          child: Container(
            width: 15,
            height: 15,
          )
        )
      ],
    ),
  );
}

