import 'package:flutter/material.dart';
import 'package:tienda_virtual/modelo.dart';
import 'package:toast/toast.dart';

class PageCrear extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PageCrear> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 18.0);
  // final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    final nombreField = TextField(
      controller: TextEditingController(),
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Nombre",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final confirmarField = TextField(
      controller: TextEditingController(),
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Confirmar Contraseña",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final telefonoField = TextField(
      controller: TextEditingController(),
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Telefono",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );


    final apellidoField = TextField(
      controller: TextEditingController(),
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Apellido",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );


    final emailField = TextField(
      controller: TextEditingController(),
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Correo",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      controller: TextEditingController(),
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Contraseña",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

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

          //  crearClientePOST(url_service, cliente);
          }
        },
        child: Text("Crear",
            textAlign: TextAlign.center,
            style: style.copyWith(
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

                      child: Image.network("https://scontent.fcue3-1.fna.fbcdn.net/v/t1.0-9/83779753_2705587112851892_785769828785848320_n.jpg?_nc_cat=107&_nc_oc=AQlutAnIEKeH-Ahfi82HIv4ekR58iaef_I1NChcJu3F6inMEGQ7i0pmidZ1wcdEhGSI&_nc_ht=scontent.fcue3-1.fna&oh=d5f03868c32623da6de2e450999cfada&oe=5EBE1CFF",
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