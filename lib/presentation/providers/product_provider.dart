
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/producto.dart';
import 'repository_providers.dart';

// 1. Provider to fetch all products
final productsFutureProvider = FutureProvider<List<Producto>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProductos();
});

// 2. Provider for search query
final productSearchQueryProvider = StateProvider<String>((ref) => '');

// 3. Provider for filtered products
final filteredProductsProvider = Provider<AsyncValue<List<Producto>>>((ref) {
  final productsAsync = ref.watch(productsFutureProvider);
  final query = ref.watch(productSearchQueryProvider);

  return productsAsync.whenData((products) {
    if (query.isEmpty) {
      return products;
    }
    return products.where((p) => 
      p.nombre.toLowerCase().contains(query.toLowerCase())
    ).toList();
  });
});

// 4. Controller for actions (create product, refresh)
class ProductActionsNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;

  ProductActionsNotifier(this._ref) : super(const AsyncValue.data(null));

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
       // Invalidating the FutureProvider will cause it to refetch
      _ref.refresh(productsFutureProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createProduct(Producto producto) async {
    state = const AsyncValue.loading();
    try {
      final repository = _ref.read(productRepositoryProvider);
      await repository.crearProducto(producto);
      await refresh(); // Refresh list after creation
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final productActionsProvider = StateNotifierProvider<ProductActionsNotifier, AsyncValue<void>>((ref) {
  return ProductActionsNotifier(ref);
});
