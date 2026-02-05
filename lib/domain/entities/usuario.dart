class Usuario {
  final int? id;
  final String nombreCompleto;
  final String email;
  final String? password;
  final String rol;

  const Usuario({
    this.id,
    required this.nombreCompleto,
    required this.email,
    this.password,
    this.rol = 'CLIENTE',
  });
}
