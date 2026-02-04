class Usuario {
  final int? id;
  final String nombreCompleto;
  final String email;
  final String? password; // Puede ser null cuando lo recibimos del server (por seguridad)
  final String rol;

  Usuario({
    this.id,
    required this.nombreCompleto,
    required this.email,
    this.password,
    this.rol = 'CLIENTE',
  });

  // De JSON (Java) a Dart
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombreCompleto: json['nombreCompleto'],
      email: json['email'],
      rol: json['rol'],
    );
  }

  // De Dart a JSON (Para enviar a Java)
  Map<String, dynamic> toJson() {
    return {
      'nombreCompleto': nombreCompleto,
      'email': email,
      'password': password,
      'rol': rol,
    };
  }
}