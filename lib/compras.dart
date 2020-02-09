
import 'package:flutter/material.dart';
import 'package:tienda_virtual/compra.dart';
import 'package:tienda_virtual/modelo.dart';
import 'package:tienda_virtual/servicios.dart';

class PageCompras extends StatelessWidget {
  final Cliente cliente;

  const PageCompras({Key key, this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(

        title: Text(''),
      ),
      body: Center(
        child: FutureBuilder<List<Compra>>(
          future: listarCompras(cliente.codigo),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  var compra = snapshot.data[index];
                  return ListTile(
                    title: Text(
                      compra.fecha,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent
                      ),
                    ),
                    subtitle: Text(
                      "\$"+compra.total.toString(),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageCompra(cliente: cliente,compra: compra,),
                        ),
                      );
                    },
                  );
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