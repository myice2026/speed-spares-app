
import '../entities/usuario.dart';

abstract class AuthRepository {
  Future<Usuario?> login(String email, String password);
  Future<Usuario?> register(Usuario usuario);
  Future<void> logout();
}
