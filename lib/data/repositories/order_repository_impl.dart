
import '../../domain/entities/pedido.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/remote/api_service.dart';

class OrderRepositoryImpl implements OrderRepository {
  final ApiService _apiService;

  OrderRepositoryImpl(this._apiService);

  @override
  Future<void> crearPedido(int usuarioId, int productoId) async {
    await _apiService.crearPedido(usuarioId, productoId);
  }

  @override
  Future<List<Pedido>> getPedidosUsuario(int usuarioId) async {
    return await _apiService.getPedidosUsuario(usuarioId);
  }
}
