import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_virtual/modelo.dart';
import 'package:tienda_virtual/producto.dart';
import 'package:tienda_virtual/servicios.dart';
import 'package:tienda_virtual/carrito.dart';
import 'package:tienda_virtual/compras.dart';

class PageInicio extends StatelessWidget {
  final Cliente cliente;

  const PageInicio({Key key, this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

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
          )
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