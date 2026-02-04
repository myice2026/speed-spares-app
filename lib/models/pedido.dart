class Pedido {
  final int id;
  final String fecha;
  final String estado;
  final String nombreProducto;
  final double precio;

  Pedido({
    required this.id,
    required this.fecha,
    required this.estado,
    required this.nombreProducto,
    required this.precio,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'],
      fecha: json['fecha'].toString(),
      estado: json['estado'],
      // OJO AQUÍ: Accedemos a los datos del objeto 'producto' que viene dentro
      nombreProducto: json['producto']['nombre'],
      precio: (json['producto']['precio'] as num).toDouble(),
    );
  }
}