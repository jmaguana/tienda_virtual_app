
import 'package:flutter/material.dart';
import 'package:tienda_virtual/main.dart';

import 'modelo.dart';

class PageCliente extends StatelessWidget {
  final Cliente cliente;

  const PageCliente({Key key, this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto de compra'),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.white,
                ),
                onPressed: (){
                  print("Compartidos");
                  Route route = MaterialPageRoute(builder: (context)=> MyApp());
                  Navigator.pushReplacement(context, route);
                }
            ),
          ]
      ),
      body: Center(
        child: Container(
          width: 300.0,
          height: 300.0,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 48.0,
                  child: Image.network("https://thumbs.dreamstime.com/b/icono-del-avatar-usuario-bot%C3%B3n-s%C3%ADmbolo-perfil-plano-de-la-persona-vector-131363829.jpg")
                ),
                //NetworkImage("https://thumbs.dreamstime.com/b/icono-del-avatar-usuario-bot%C3%B3n-s%C3%ADmbolo-perfil-plano-de-la-persona-vector-131363829.jpg"),
                new Text(
                  " "+cliente.nombre+" "+cliente.apellido,
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                new SizedBox(
                  height: 25.0,
                ),
                new Text(
                  " "+cliente.correo,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.indigo,
                  ),
                ),
                new Text(
                  cliente.telefono != null ? " "+cliente.telefono: " 0000000",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.indigo,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),


    );
  }

}