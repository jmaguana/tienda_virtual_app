
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_virtual/modelo.dart';
import 'package:tienda_virtual/servicios.dart';
import 'package:toast/toast.dart';

class PageCompartir extends StatelessWidget {
  final Cliente cliente;
  final Producto producto;
  const PageCompartir({Key key, this.cliente, this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build0
    return Scaffold(
        appBar: new AppBar(
          title: Text(producto.nombre),
        ),
      body: Center(
        child: Column(
          children: <Widget>[

            new Container(
              //padding: new EdgeInsets.all(32.0),
              child: Card(
                child: Row(

                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 50.0,
                      child: Image.network(producto.imagen),
                    ),
                    new Container(
                      width: 300.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            producto.nombre,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.indigo,
                            ),
                          ),
                          new Text(
                            producto.descripcion,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 250.0,

                child: FutureBuilder<List<Cliente>>(
                  future: listarCliente(cliente.codigo),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index){
                      /*if(snapshot.data[index].codigo == cliente.codigo){
                        return null;
                      }*/
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage("https://thumbs.dreamstime.com/b/icono-del-avatar-usuario-bot%C3%B3n-s%C3%ADmbolo-perfil-plano-de-la-persona-vector-131363829.jpg"),
                          ),
                          title: Text(
                              snapshot.data[index].nombre
                          ),
                          subtitle: Text(
                              snapshot.data[index].correo,
                        ),

                        onTap: (){
                          showDialog(
                            context: context,
                              barrierDismissible: false,
                            child: new CupertinoAlertDialog(
                              title: Text("Compartir"),
                              content: Text('Compartir "' + producto.nombre+'" con '+snapshot.data[index].nombre+"?"),
                              actions: <Widget>[
                                new FlatButton(
                                    onPressed: (){
                                      compartir(cliente.codigo, snapshot.data[index].codigo, producto.codigo).then((onValue){
                                        Toast.show(
                                            "Se compartió el producto correctamente.", context,
                                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      });

                                    },
                                    child: new Text("Compartir")
                                ),
                                new FlatButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: new Text("Cancelar")
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
            )
            )
          ],
        ),
      ),


    );
  }

}