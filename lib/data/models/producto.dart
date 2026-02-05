
import '../../domain/entities/producto.dart';

class ProductoModel extends Producto {
  const ProductoModel({
    int? id,
    required String nombre,
    required String descripcion,
    required double precio,
  }) : super(
          id: id,
          nombre: nombre,
          descripcion: descripcion,
          precio: precio,
        );

  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    return ProductoModel(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'] ?? '',
      precio: (json['precio'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
    };
  }
}