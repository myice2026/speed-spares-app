class RolModel {
  final int id;
  final String nombre;

  RolModel({required this.id, required this.nombre});

  factory RolModel.fromJson(Map<String, dynamic> json) {
    return RolModel(
      id: json['id'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }
}
