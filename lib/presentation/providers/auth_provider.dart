
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/usuario.dart';
import '../../domain/repositories/auth_repository.dart';
import 'repository_providers.dart';

// State class for Auth
class AuthState {
  final Usuario? usuario;
  final bool isLoading;
  final String? errorMessage;

  const AuthState({this.usuario, this.isLoading = false, this.errorMessage});

  AuthState copyWith({Usuario? usuario, bool? isLoading, String? errorMessage}) {
    return AuthState(
      usuario: usuario ?? this.usuario,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // If passed, replace. If null passed, it might mean clear error? 
      // Simplified: explicit null clearing would need a sentinel, but here we assume if we want to clear we pass null
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState());

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await _repository.login(email, password);
      state = AuthState(usuario: user, isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> register(String nombre, String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final newUser = Usuario(nombreCompleto: nombre, email: email, password: password, roles: 'CLIENTE');
      // Note: Repository expects a user object, usually without ID for pure registration
      final user = await _repository.register(newUser);
      
      // Auto-login after register logic usually? Or just set user
      state = AuthState(usuario: user, isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  void logout() {
    _repository.logout();
    state = const AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});
