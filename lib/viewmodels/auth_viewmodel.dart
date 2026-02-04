import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  Usuario? _usuarioActual; // Aquí guardamos quién inició sesión
  bool _cargando = false;
  String _mensajeError = '';

  Usuario? get usuarioActual => _usuarioActual;
  bool get cargando => _cargando;
  String get mensajeError => _mensajeError;

  // Lógica de Login
  Future<bool> login(String email, String password) async {
    _cargando = true;
    _mensajeError = '';
    notifyListeners();

    try {
      _usuarioActual = await _authService.login(email, password);
      _cargando = false;
      notifyListeners();
      return true; // Éxito
    } catch (e) {
      _mensajeError = e.toString().replaceAll("Exception: ", "");
      _cargando = false;
      notifyListeners();
      return false; // Falló
    }
  }

  // Lógica de Registro
  Future<bool> registrar(String nombre, String email, String password) async {
    _cargando = true;
    _mensajeError = '';
    notifyListeners();

    try {
      Usuario nuevo = Usuario(nombreCompleto: nombre, email: email, password: password);
      _usuarioActual = await _authService.registro(nuevo);
      _cargando = false;
      notifyListeners();
      return true;
    } catch (e) {
      _mensajeError = "Falló el registro. Intenta con otro email.";
      _cargando = false;
      notifyListeners();
      return false;
    }
  }
  
  // Cerrar sesión
  void logout() {
    _usuarioActual = null;
    notifyListeners();
  }
}