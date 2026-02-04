import 'package:flutter/material.dart';
import '../models/pedido.dart';
import '../services/api_service.dart';

class PedidoViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();
  List<Pedido> _pedidos = [];
  bool _cargando = false;

  List<Pedido> get pedidos => _pedidos;
  bool get cargando => _cargando;

  Future<void> cargarPedidos(int usuarioId) async {
    _cargando = true;
    notifyListeners();

    try {
      _pedidos = await _api.getPedidosUsuario(usuarioId);
    } catch (e) {
      print(e);
      _pedidos = [];
    }

    _cargando = false;
    notifyListeners();
  }
}