
import '../../domain/entities/usuario.dart';

class UsuarioModel extends Usuario {
  const UsuarioModel({
    int? id,
    required String nombreCompleto,
    required String email,
    String? password,
    String rol = 'CLIENTE',
  }) : super(
          id: id,
          nombreCompleto: nombreCompleto,
          email: email,
          password: password,
          rol: rol,
        );

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'],
      nombreCompleto: json['nombreCompleto'],
      email: json['email'],
      rol: json['rol'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombreCompleto': nombreCompleto,
      'email': email,
      'password': password,
      'rol': rol,
    };
  }
}