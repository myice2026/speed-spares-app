import '../../domain/entities/pedido.dart';

class PedidoModel extends Pedido {
  const PedidoModel({
    int? id,
    required int usuarioId,
    required int productoId,
    required String fecha,
    required String estado,
    String? nombreProducto,
    double? precio,
  }) : super(
          id: id,
          usuarioId: usuarioId,
          productoId: productoId,
          fecha: fecha,
          estado: estado,
          nombreProducto: nombreProducto,
          precio: precio,
        );

  factory PedidoModel.fromJson(Map<String, dynamic> json) {
    return PedidoModel(
      id: json['id'],
      usuarioId:
          json['usuario'] != null ? json['usuario']['id'] : 0, // Safety check
      productoId: json['producto'] != null ? json['producto']['id'] : 0,
      fecha: json['fecha'].toString(),
      estado: json['estado'],
      nombreProducto: json['producto'] != null
          ? json['producto']['nombre']
          : 'Producto desconocido',
      precio: json['producto'] != null
          ? (json['producto']['precio'] as num).toDouble()
          : 0.0,
    );
  }
}
