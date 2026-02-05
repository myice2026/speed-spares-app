class Pedido {
  final int? id;
  final int usuarioId;
  final int productoId;
  final String fecha;
  final String estado;
  // Display fields
  final String? nombreProducto;
  final double? precio;

  const Pedido({
    this.id,
    required this.usuarioId,
    required this.productoId,
    required this.fecha,
    required this.estado,
    this.nombreProducto,
    this.precio,
  });
}
