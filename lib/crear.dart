import 'package:flutter/material.dart';
import 'package:tienda_virtual/modelo.dart';
import 'package:tienda_virtual/servicios.dart';
import 'package:toast/toast.dart';
/*
class PageCrear extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}*/
class PageCrear extends StatelessWidget{

  final nombreField = TextField(
    controller: TextEditingController(),
    obscureText: false,
    style: TextStyle(fontFamily: 'Montserrat', fontSize: 18.0),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Nombre",
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  final confirmarField = TextField(
    controller: TextEditingController(),
    obscureText: true,
    style: TextStyle(fontFamily: 'Montserrat', fontSize: 18.0),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Confirmar Contraseña",
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  final telefonoField = TextField(
    controller: TextEditingController(),
    obscureText: false,
    style:TextStyle(fontFamily: 'Montserrat', fontSize: 18.0),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Telefono",
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );


  final apellidoField = TextField(
    controller: TextEditingController(),
    obscureText: false,
    style: TextStyle(fontFamily: 'Montserrat', fontSize: 18.0),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Apellido",
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );


  final emailField = new TextField(
    controller: TextEditingController(),
    obscureText: false,
    style: TextStyle(fontFamily: 'Montserrat', fontSize: 18.0),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Correo",
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  final passwordField = new TextField(
    controller: TextEditingController(),
    obscureText: true,
    style: TextStyle(fontFamily: 'Montserrat', fontSize: 18.0),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Contraseña",
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );


  @override
  Widget build(BuildContext context) {



    final crearButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if(confirmarField.controller.text != passwordField.controller.text){
            Toast.show("Verificar contraseñas", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
            print("Error");
          }else{
            Cliente cliente = new Cliente(nombre: nombreField.controller.text,
                apellido: apellidoField.controller.text,
                telefono: telefonoField.controller.text,
                correo: emailField.controller.text,
                contrasenia: passwordField.controller.text);
            print(cliente.toJson());

            crearClientePOST(cliente).then((onValue){
              Toast.show(
                  "Se creó el cliente correctamente.", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              Navigator.of(context).pop();
            });
          }
        },
        child: Text("Crear",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 18.0).copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    return Scaffold(
      appBar: new AppBar(
        title: Text("Crear Cuenta"),
      ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 155.0,

                      child: Image.asset('assets/logo.jpeg',
                        fit: BoxFit.contain,
                      ),
                    ),

                    SizedBox(height: 25.0),
                    nombreField,
                    SizedBox(height: 25.0),
                    apellidoField,
                    SizedBox(height: 25.0),
                    telefonoField,
                    SizedBox(height: 25.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(height: 25.0),
                    confirmarField,
                    SizedBox(
                      height: 35.0,
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    crearButton,
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}