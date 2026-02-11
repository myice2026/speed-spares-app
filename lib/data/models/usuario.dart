import '../../domain/entities/usuario.dart';

class UsuarioModel extends Usuario {
  const UsuarioModel({
    int? id,
    required String nombreCompleto,
    required String email,
    String? password,
    String roles = 'CLIENTE',
    String? telefono,
    bool? activo,
  }) : super(
          id: id,
          nombreCompleto: nombreCompleto,
          email: email,
          password: password,
          roles: roles,
          telefono: telefono,
          activo: activo,
        );

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'],
      nombreCompleto: json['nombreCompleto'],
      email: json['email'],
      password: json['password'],
      roles: json['roles'] != null ? (json['roles'] as List).first : 'CLIENTE',
      telefono: json['telefono'],
      activo: json['activo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombreCompleto': nombreCompleto,
      'email': email,
      'password': password,
      'roles': roles,
      'telefono': telefono,
      'activo': activo,
    };
  }
}