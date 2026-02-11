class Producto {
  final int? id;
  final String nombre;
  final String? descripcion;
  final String? descripcionLarga;
  final double precio;
  final String? sku;
  final int? cantidadStock;
  final String? imagenPrincipalUrl;
  final bool activo;
  final int? idCategoria;

  const Producto({
    this.id,
    required this.nombre,
    this.descripcion,
    this.descripcionLarga,
    required this.precio,
    this.sku,
    this.cantidadStock,
    this.imagenPrincipalUrl,
    this.activo = true,
    this.idCategoria,
  });
}
