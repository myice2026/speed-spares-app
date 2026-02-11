import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import 'product_detail_view.dart';

class ProductosView extends ConsumerStatefulWidget {
  const ProductosView({super.key});

  @override
  ConsumerState<ProductosView> createState() => _ProductosViewState();
}

class _ProductosViewState extends ConsumerState<ProductosView> {
  @override
  Widget build(BuildContext context) {
    // Escuchar los productos filtrados (ya incluye la búsqueda)
    final productsAsync = ref.watch(filteredProductsProvider);
    final searchQuery = ref.watch(productSearchQueryProvider);
    final isSearching = searchQuery.isNotEmpty;

    const Color kBackgroundColor = Color(0xFFF5F5F7); // Fondo más claro/moderno
    const Color kPrimaryColor = Color(0xFF2962FF);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Speed Spares',
              style: GoogleFonts.outfit(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search, color: Colors.grey[800]),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: ProductSearchDelegate(ref),
                  );
                },
              ),
              IconButton(
                icon:
                    Icon(Icons.shopping_cart_outlined, color: Colors.grey[800]),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Carrito en desarrollo")),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
            bottom: isSearching
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(60),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            "Resultados para: ",
                            style: GoogleFonts.outfit(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          Chip(
                            label: Text(
                              searchQuery,
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: kPrimaryColor.withOpacity(0.1),
                            deleteIcon: Icon(Icons.close,
                                size: 16, color: kPrimaryColor),
                            onDeleted: () {
                              ref
                                  .read(productSearchQueryProvider.notifier)
                                  .state = '';
                            },
                            side: BorderSide.none,
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: productsAsync.when(
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, stack) => SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          size: 64, color: Colors.red[400]),
                      const SizedBox(height: 16),
                      Text(
                        "Error al cargar productos",
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => ref.refresh(productsFutureProvider),
                        icon: const Icon(Icons.refresh),
                        label: const Text("Reintentar"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              data: (products) {
                if (products.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inventory_2_outlined,
                              size: 80, color: Colors.grey[300]),
                          const SizedBox(height: 16),
                          Text(
                            isSearching
                                ? "No se encontraron productos"
                                : "No hay productos disponibles",
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.70, // Slightly taller cards
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final producto = products[index];
                      return ProductCard(
                        producto: producto,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailView(producto: producto),
                            ),
                          );
                        },
                      );
                    },
                    childCount: products.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.refresh(productsFutureProvider),
        child: const Icon(Icons.refresh),
        tooltip: 'Refrescar',
      ),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate {
  final WidgetRef ref;

  ProductSearchDelegate(this.ref);

  @override
  String get searchFieldLabel => 'Buscar repuestos...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Set the global search query
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productSearchQueryProvider.notifier).state = query;
      close(context, null);
    });
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Colors.white,
      child: query.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 64, color: Colors.grey[200]),
                  const SizedBox(height: 16),
                  Text(
                    "Busca por nombre de producto",
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
            )
          : ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.search),
                  title: RichText(
                    text: TextSpan(
                      text: 'Buscar ',
                      style: const TextStyle(color: Colors.black54),
                      children: [
                        TextSpan(
                          text: query,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    showResults(context);
                  },
                ),
              ],
            ),
    );
  }
}
