import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tienda_virtual/modelo.dart';

final servicioUrl = 'http://192.168.0.106:8080/tienda-virtual/srv/';

Future<Cliente> login(String correo, String contrasenia) async {
  String aux = servicioUrl+'clientes/login/'+correo.replaceAll(" ", "")+"/"+contrasenia;
  print(aux);
  final response = await http.get(aux);
  if(response.statusCode == 200){
    return Cliente.fromJson(json.decode(response.body));
  }else{
    print("Error iniciando sesion");
    throw Exception('Falló inicio de sesion');
  }
}

Future<List<Cliente>> listarCliente() async {
  final response = await http.get(servicioUrl+'clientes/listar');
  var clientes = new List<Cliente>();
  if(response.statusCode == 200){
    Iterable list = json.decode(response.body);
    clientes = list.map((model) => Cliente.fromJson(model)).toList();
    return clientes;
  }else{
    throw Exception('Fallo cargando Clientes');
  }
}

Future<List<Producto>> listarProducto() async {
  final response = await http.get(servicioUrl+'productos/listar');
  List<Producto> productos = new List<Producto>();
  if(response.statusCode == 200){
    Iterable list = json.decode(response.body);
    productos = list.map((model) => Producto.fromJson(model)).toList();
    return productos;
  }else{
    throw Exception('Fallo cargando Productos');
  }
}

Future<List<Producto>> listarProductoCarrito(int id) async {
  final response = await http.get(servicioUrl+'carrito/listar/'+id.toString());
  List<Producto> productos = new List<Producto>();
  if(response.statusCode == 200){
    Iterable list = json.decode(response.body);
    productos = list.map((model) => Producto.fromJson(model)).toList();
    return productos;
  }else{
    throw Exception('Fallo cargando Productos');
  }
}

Future<List<Compra>> listarCompras(int id) async {
  final response = await http.get(servicioUrl+'compras/listar/'+id.toString());
  List<Compra> compras = new List<Compra>();
  if(response.statusCode == 200){
    Iterable list = json.decode(response.body);
    compras = list.map((model) => Compra.fromJson(model)).toList();
    return compras;
  }else{
    throw Exception('Fallo cargando Compras');
  }
}

Future<List<Producto>> listarProductosCompra(int id) async{
  final response = await http.get(servicioUrl+'compras/listar/'+id.toString());
  List<Producto> productos = new List<Producto>();
  if(response.statusCode == 200){
    Iterable list = json.decode(response.body);
    productos = list.map((model) => Producto.fromJson(model)).toList();
    return productos;
  }else{
    throw Exception('Fallo cargando Productos de compra');
  }
}

Future<String> generarCompra(int id) async{
  final response = await http.get(servicioUrl+'compras/generarCompra/'+id.toString());
  if(response.statusCode == 200){
    return response.body;
  }else{
    throw Exception('Fallo agregando a carrito');
  }
}

Future<Producto> buscarProducto(int id) async{
  final response = await http.get(servicioUrl+'productos/buscar/'+id.toString());
  if(response.statusCode == 200){
    return Producto.fromJson(json.decode(response.body));
  }else{
    throw Exception('Fallo agregando a carrito');
  }
}

Future<bool> isLiked(int idClinete, int idProducto) async{
  final response = await http.get(servicioUrl+'productos/islike/'+idProducto.toString()+"/"+idClinete.toString());
  if(response.statusCode == 200){
    print(response.body);
    return response.body.toLowerCase() == 'true';
  }else{
    throw Exception('Fallo agregando a carrito');
  }
}

Future<void> darLike(int idClinete, int idProducto, bool isLiked) async{

  if(isLiked){
    final response = await http.get(servicioUrl+'productos/like/'+idProducto.toString()+"/"+idClinete.toString()+"/0");

    if(response.statusCode == 200){
      print(response.body);

    }else{
      throw Exception('Fallo agregando a carrito');
    }
  }else{
    final response = await http.get(servicioUrl+'productos/like/'+idProducto.toString()+"/"+idClinete.toString()+"/1");
    if(response.statusCode == 200){
      print(response.body);

    }else{
      throw Exception('Fallo dar like');
    }
  }

}

Future<void> agregarCarrito(int cantidad, int codigoProducto, int codigoCliente) async{
  final response = await http.get(servicioUrl+'carrito/insertar/'+codigoCliente.toString()+'/'+codigoProducto.toString()+'/'+cantidad.toString());
  if(response.statusCode == 200){

  }else{
    throw Exception('Fallo agregando a carrito');
  }
}