
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/product_list_empty.dart';
import '../widgets/product_skeleton_loader.dart';
import '../widgets/app_bar_custom.dart';
import 'detalle_producto_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(filteredProductsProvider);
    final authState = ref.watch(authProvider);
    final user = authState.usuario;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Speed Spares',
        bottom: CustomSearchBar(
          onChanged: (text) {
            ref.read(productSearchQueryProvider.notifier).state = text;
          },
        ),
      ),
      drawer: CustomDrawer(user: user),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.refresh(productsFutureProvider.future);
        },
        child: productsAsync.when(
          loading: () => const ProductSkeletonLoader(),
          error: (error, stackTrace) => _ErrorWidget(error: error),
          data: (productos) {
            if (productos.isEmpty) {
              return const ProductListEmpty();
            }
            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
                return ProductCard(
                  key: ValueKey(producto.id),
                  producto: producto,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleProductoView(
                          producto: producto,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final Object error;

  const _ErrorWidget({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 50,
                color: Colors.red[600],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Oops, algo salió mal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              onPressed: () {
                // El refresh será manejado por el RefreshIndicator
              },
            ),
          ],
        ),
      ),
    );
  }
}