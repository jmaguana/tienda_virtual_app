import 'package:flutter/material.dart';
import 'package:tienda_virtual/modelo.dart';
import 'package:tienda_virtual/servicios.dart';
import 'package:toast/toast.dart';

class PageComprar extends StatelessWidget {
  final Cliente cliente;

  const PageComprar({Key key, this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final crearButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
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
        },
        child: Text("Generar Compra",
            textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold)
          ),
            //style: style.copyWith(
               // color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    return Scaffold(
      appBar: new AppBar(
        title: Text("Comprar"),
      ),
      body: Center(
      child: Container(
        color: Colors.white,
        child: new FutureBuilder<Compra>(
        future: preCompra(cliente.codigo),
        builder: (context, snapshot) {
    if(snapshot.hasData){
      if(snapshot.data.totalProductos == 0){
        Navigator.of(context).pop();
      }
      return Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 55.0,
                ),
                new Text(
                  snapshot.data.fecha
                ),

                SizedBox(
                  height: 35.0,
                ),
                new Text(
                  "Total \$"+snapshot.data.total.toString()
                ),
                SizedBox(
                  height: 35.0,
                ),
                new Text(
                    snapshot.data.totalProductos.toString()+" productos"
                ),
                SizedBox(
                  height: 95.0,
                ),
                crearButton,
                SizedBox(
                  height: 15.0,
                ),
              ]
          )
      );
    }else if(snapshot.hasError){
      Navigator.of(context).pop();
      return Text("${snapshot.error}");
    }
    return CircularProgressIndicator();
    }
      )
      )
    ),
    );
  }

}