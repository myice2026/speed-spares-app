
import '../../domain/entities/usuario.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_service.dart';
import '../models/usuario.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<Usuario?> login(String email, String password) async {
    try {
      final model = await _authService.login(email, password);
      return model;
    } catch (e) {
      // In a real app we might map exceptions to Failures
      throw Exception(e.toString());
    }
  }

  @override
  Future<Usuario?> register(Usuario usuario) async {
    try {
      // Convert abstract Entity to Model to pass to API
      final usuarioModel = UsuarioModel(
        nombreCompleto: usuario.nombreCompleto,
        email: usuario.email,
        password: usuario.password,
        rol: usuario.rol,
      );
      final model = await _authService.registro(usuarioModel);
      return model;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    // Local cleanup if necessary
  }
}
