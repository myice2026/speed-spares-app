class CategoriaModel {
  final int id;
  final String nombre;
  final String? descripcion;

  CategoriaModel({required this.id, required this.nombre, this.descripcion});

  factory CategoriaModel.fromJson(Map<String, dynamic> json) {
    return CategoriaModel(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }
}
