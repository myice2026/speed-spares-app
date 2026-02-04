import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:speed_spares_app/models/pedido.dart';
import 'package:speed_spares_app/models/taller.dart';
import '../models/producto.dart';
import 'dart:io'; // Para detectar si es Android o iOS

class ApiService {
  // Detecta automáticamente la IP correcta según el emulador
  String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/productos';
    } else {
      return 'http://localhost:8080/api/productos'; // Para iOS o Web
    }
  }

  // Obtener lista de productos
  Future<List<Producto>> getProductos() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((item) => Producto.fromJson(item)).toList();
      } else {
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Crear un producto nuevo (para probar que guarda)
  Future<void> crearProducto(Producto producto) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(producto.toJson()),
    );
  }

  Future<void> crearPedido(int usuarioId, int productoId) async {
    // Nota: Cambiamos la URL base temporalmente para apuntar a pedidos
    final urlPedidos = baseUrl.replaceAll("/productos", "/pedidos/comprar");

    final response = await http.post(
      Uri.parse(urlPedidos),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"usuarioId": usuarioId, "productoId": productoId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al comprar');
    }
  }
  Future<List<Pedido>> getPedidosUsuario(int usuarioId) async {
    // URL: http://.../api/pedidos/usuario/1
    final url = baseUrl.replaceAll("/productos", "/pedidos/usuario/$usuarioId");
    
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => Pedido.fromJson(item)).toList();
    } else {
      throw Exception('No se pudieron cargar los pedidos');
    }
  }
// Obtener Talleres
  Future<List<Taller>> getTalleres() async {
    final url = baseUrl.replaceAll("/productos", "/talleres"); // Cambia la ruta
    // Nota: Si baseUrl termina en /auth, asegúrate de ajustarlo. 
    // Lo ideal es tener una variable BASE_URL_ROOT = 'http://10.0.2.2:8080/api';
    // Pero usemos este truco rápido:
    final urlFinal = 'http://10.0.2.2:8080/api/talleres'; 
    
    final response = await http.get(Uri.parse(urlFinal));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => Taller.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar talleres');
    }
  }
}   


