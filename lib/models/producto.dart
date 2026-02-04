class Producto {
  final int? id;
  final String nombre;
  final String descripcion;
  final double precio;

  Producto({this.id, required this.nombre, required this.descripcion, required this.precio});

  // Convertir lo que llega de Java (JSON) a Dart
  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'] ?? '',
      precio: (json['precio'] as num).toDouble(),
    );
  }

  // Convertir de Dart a JSON para enviar a Java
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
    };
  }
}