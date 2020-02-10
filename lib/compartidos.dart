import 'package:flutter/material.dart';
import 'package:tienda_virtual/modelo.dart';
import 'package:tienda_virtual/producto.dart';
import 'package:tienda_virtual/servicios.dart';

class PageCompartidos extends StatelessWidget {
  final Cliente cliente;

  const PageCompartidos({Key key, this.cliente}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
          title: Text("Productos compartidos")
      ),
      body: Center(
        child: FutureBuilder<List<Producto>>(
          future: listarCompartido(cliente.codigo),
          builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var producto = snapshot.data[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: producto.imagen !=null ? NetworkImage(producto.imagen): NetworkImage("https://image.flaticon.com/icons/png/512/107/107831.png"),
                    //backgroundImage: NetworkImage(producto.imagen),
                  ),
                  title: Text(
                    producto.nombre,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54
                    ),

                  ),
                  subtitle: Text(
                    "Compartido por: " +producto.correocompartido,
                    style: TextStyle(
                      color: Colors.green,
                    ),
                    maxLines: 1,
                  ),

                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageProducto(producto: producto,cliente: cliente,),
                      ),
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
    );
  }

}
