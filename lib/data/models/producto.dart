import '../../domain/entities/producto.dart';

class ProductoModel extends Producto {
  const ProductoModel({
    int? id,
    required String nombre,
    String? descripcion,
    String? descripcionLarga,
    required double precio,
    String? sku,
    int? cantidadStock,
    String? imagenPrincipalUrl,
    bool activo = true,
    int? idCategoria,
  }) : super(
          id: id,
          nombre: nombre,
          descripcion: descripcion,
          descripcionLarga: descripcionLarga,
          precio: precio,
          sku: sku,
          cantidadStock: cantidadStock,
          imagenPrincipalUrl: imagenPrincipalUrl,
          activo: activo,
          idCategoria: idCategoria,
        );

  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    return ProductoModel(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'],
      descripcionLarga: json['descripcionLarga'],
      precio: (json['precio'] as num).toDouble(),
      sku: json['sku'],
      cantidadStock: json['cantidadStock'],
      imagenPrincipalUrl: json['imagenPrincipalUrl'],
      activo: json['activo'] ?? true,
      idCategoria: json['categoria'] != null ? json['categoria']['id'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'descripcionLarga': descripcionLarga,
      'precio': precio,
      'sku': sku,
      'cantidadStock': cantidadStock,
      'imagenPrincipalUrl': imagenPrincipalUrl,
      'activo': activo,
      'categoriaId': idCategoria,
    };
  }
}
