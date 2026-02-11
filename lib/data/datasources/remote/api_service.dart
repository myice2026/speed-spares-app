import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/pedido.dart';
import '../../models/taller.dart';
import '../../models/producto.dart';
import '../../models/rol.dart';
import '../../models/categoria.dart';
import '../../models/usuario.dart';
import 'dart:io';

class ApiService {
  String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api';
    } else {
      return 'http://localhost:8080/api';
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  // Obtener lista de productos
  Future<List<ProductoModel>> getProductos() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/producto')); // Backend: /api/producto
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((item) => ProductoModel.fromJson(item)).toList();
      } else {
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Crear un producto nuevo
  Future<void> crearProducto(ProductoModel producto) async {
    final headers = await _getHeaders();
    await http.post(
      Uri.parse('$baseUrl/producto'),
      headers: headers,
      body: jsonEncode(producto.toJson()),
    );
  }

  Future<void> crearPedido(int usuarioId, int productoId) async {
    final headers = await _getHeaders();
    // Backend: POST /api/pedidos expecting PedidoDTO.Request
    // Request body: { "usuarioId": ..., "productoId": ..., "cantidad": 1 }
    final body = {
      "usuarioId": usuarioId,
      "productoId": productoId,
      "cantidad": 1
    };

    final response = await http.post(
      Uri.parse('$baseUrl/pedidos'),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al comprar: ${response.body}');
    }
  }

  Future<List<PedidoModel>> getPedidosUsuario(int usuarioId) async {
    // Backend: GET /api/pedidos (returns orders for current user)
    // We ignore usuarioId param as the token determines the user
    final headers = await _getHeaders();

    final response =
        await http.get(Uri.parse('$baseUrl/pedidos'), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => PedidoModel.fromJson(item)).toList();
    } else {
      throw Exception(
          'No se pudieron cargar los pedidos: ${response.statusCode}');
    }
  }

  // Obtener Talleres
  Future<List<TallerModel>> getTalleres() async {
    final headers = await _getHeaders();
    final response =
        await http.get(Uri.parse('$baseUrl/talleres'), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => TallerModel.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar talleres: ${response.statusCode}');
    }
  }

  // Obtener Roles
  Future<List<RolModel>> getRoles() async {
    final headers = await _getHeaders();
    final response =
        await http.get(Uri.parse('$baseUrl/roles'), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => RolModel.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar roles: ${response.statusCode}');
    }
  }

  // Obtener Categorías
  Future<List<CategoriaModel>> getCategorias() async {
    final headers = await _getHeaders();
    final response =
        await http.get(Uri.parse('$baseUrl/categorias'), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => CategoriaModel.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar categorías: ${response.statusCode}');
    }
  }

  // Crear Categoría
  Future<void> crearCategoria(CategoriaModel categoria) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/categorias'),
      headers: headers,
      body: jsonEncode(categoria.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al crear categoría: ${response.statusCode}');
    }
  }

  // Obtener Usuarios
  Future<List<UsuarioModel>> getUsuarios() async {
    final headers = await _getHeaders();
    final response =
        await http.get(Uri.parse('$baseUrl/usuarios'), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => UsuarioModel.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar usuarios: ${response.statusCode}');
    }
  }
}
