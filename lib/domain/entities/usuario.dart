class Usuario {
  final int? id;
  final String nombreCompleto;
  final String email;
  final String? password;
  final String roles;
  final String? telefono;
  final bool? activo;

  const Usuario({
    this.id,
    required this.nombreCompleto,
    required this.email,
    this.password,
    required this.roles,
    this.telefono,
    this.activo,
  });
}
