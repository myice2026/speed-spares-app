
import '../entities/pedido.dart';

abstract class OrderRepository {
  Future<void> crearPedido(int usuarioId, int productoId);
  Future<List<Pedido>> getPedidosUsuario(int usuarioId);
}
