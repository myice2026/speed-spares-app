import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../services/api_service.dart';

class ProductoViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();
  
  List<Producto> _productosOriginales = []; // La "Bodega" (todos los datos)
  List<Producto> _productos = [];           // La "Vitrina" (lo que se ve en pantalla)
  bool _cargando = false;
  String _mensajeError = '';

  List<Producto> get productos => _productos;
  bool get cargando => _cargando;
  String get mensajeError => _mensajeError;

  // Cargar datos desde el Backend
  Future<void> cargarProductos() async {
    _cargando = true;
    _mensajeError = '';
    notifyListeners(); // Avisa a la pantalla: "Pon el relojito de carga"

    try {
      // 1. Guardamos la lista completa en la variable "original"
      _productosOriginales = await _api.getProductos(); 
      
      // 2. Al principio, la lista visible es igual a la original (copia)
      _productos = List.from(_productosOriginales);     
      
    } catch (e) {
      _mensajeError = "No se pudo conectar: $e";
    }

    _cargando = false;
    notifyListeners(); // Avisa a la pantalla: "Ya tengo los datos"
  }

  // Función para filtrar (Buscador)
  void buscar(String query) {
    if (query.isEmpty) {
      // Si borran el texto, volvemos a mostrar la copia completa de la original
      _productos = List.from(_productosOriginales); 
    } else {
      // Si escriben algo, filtramos sobre la lista ORIGINAL
      _productos = _productosOriginales.where((p) {
        return p.nombre.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners(); // Avisamos a la pantalla que la lista cambió
  }

  // Agregar producto de prueba (Opcional, útil para verificar)
  Future<void> agregarPrueba() async {
    _cargando = true;
    notifyListeners();
    try {
      Producto nuevo = Producto(
        nombre: "Bujía Spark", 
        descripcion: "Bujía de alto rendimiento", 
        precio: 12500
      );
      await _api.crearProducto(nuevo);
      await cargarProductos(); // Recarga la lista para ver el nuevo
    } catch (e) {
      _mensajeError = "Error al guardar";
    }
    _cargando = false;
    notifyListeners();
  }
}