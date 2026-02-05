
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/pedido.dart';
import 'repository_providers.dart';
import 'auth_provider.dart';

final userOrdersProvider = FutureProvider.autoDispose<List<Pedido>>((ref) async {
  final authState = ref.watch(authProvider);
  final user = authState.usuario;

  if (user == null || user.id == null) {
    return [];
  }

  final repository = ref.watch(orderRepositoryProvider);
  return repository.getPedidosUsuario(user.id!);
});

class OrderNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;

  OrderNotifier(this._ref) : super(const AsyncValue.data(null));

  Future<void> createOrder(int productoId) async {
    final authState = _ref.read(authProvider);
    final user = authState.usuario;

    if (user == null || user.id == null) {
      state = AsyncValue.error("Usuario no autenticado", StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final repository = _ref.read(orderRepositoryProvider);
      await repository.crearPedido(user.id!, productoId);
      // Refresh the orders list
      _ref.refresh(userOrdersProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final orderActionsProvider = StateNotifierProvider<OrderNotifier, AsyncValue<void>>((ref) {
  return OrderNotifier(ref);
});
