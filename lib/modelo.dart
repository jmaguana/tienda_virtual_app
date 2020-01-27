

class Cliente{
  final int codigo;
  final String nombre;
  final String apellido;
  final String correo;
  final String imagen;
  final int fechaNacimiento;

  Cliente({this.codigo, this.nombre, this.apellido,this.correo,this.imagen, this.fechaNacimiento});

  factory Cliente.fromJson(Map<String, dynamic> json){
    return Cliente(
      codigo: json['codigo'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      correo: json['correo'],
      imagen: json['correo'],
      fechaNacimiento: json['fechaNacimiento']
    );
  }

}

class Producto{
  final int codigo;
  final String nombre;
  final String descripcion;
  final String imagen;
  final double precio;
  final String categoria;
  final int votos;
  final int cantidad;

  Producto({this.codigo,this.nombre, this.descripcion, this.imagen, this.precio,this.categoria, this.votos, this.cantidad});

  factory Producto.fromJson(Map<String, dynamic> json){
    return Producto(
        codigo: json['codigo'],
        nombre: json['nombre'],
        descripcion: json['descripcion'],
        imagen: json['imagenes'],
        precio: json['precio'],
        categoria: json['categoria'],
        votos: json['votos'],
        cantidad: json['cantidad']
    );
  }
}

class Compra {
  final int codigo;
  final double total;
  final String fecha;
  final int totalProductos;

  Compra({this.codigo,this.total, this.fecha, this.totalProductos});

  factory Compra.fromJson(Map<String, dynamic> json){
    return Compra(
        codigo: json['id'],
        total: json['total'],
        fecha: json['fecha'],
        totalProductos: json['totalProductos']
    );
  }
}