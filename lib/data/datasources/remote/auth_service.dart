
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../models/usuario.dart';

class AuthService {
  // Detecta si es Android (10.0.2.2) o Web/iOS (localhost)
  String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/auth';
    } else {
      return 'http://localhost:8080/api/auth';
    }
  }

  // Función de Login
  Future<UsuarioModel> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return UsuarioModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Credenciales incorrectas'); // Error 401
    }
  }

  // Función de Registro
  Future<UsuarioModel> registro(UsuarioModel usuario) async {
    final response = await http.post(
      Uri.parse('$baseUrl/registro'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(usuario.toJson()),
    );

    if (response.statusCode == 200) {
      return UsuarioModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al registrar: ¿El email ya existe?');
    }
  }
}