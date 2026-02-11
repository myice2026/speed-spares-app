import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart'; // Ensure google_fonts is added or fallback to standard
 // Keep for future connection

import 'product_detail_view.dart'; // Import simplified detail view
import 'mis_pedidos_view.dart'; // Import MisPedidosView
import 'cart_view.dart'; // Import CartView
import 'catalog_view.dart'; // Import CatalogView

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  // Theme Constants for "Dark & Premium" look
  final Color kBackgroundColor = const Color(0xFF121212);
  final Color kSurfaceColor = const Color(0xFF1E1E1E);
  final Color kPrimaryAccent = const Color(0xFF2979FF); // Electric Blue
  final Color kSecondaryAccent = const Color(0xFFEC7E94); // Soft Red #EC7E94

  // Styles moved to build method to prevent LateInitializationError

  // Search State
  final TextEditingController _searchCtrl = TextEditingController();

  List<Map<String, dynamic>> _filteredProducts = [];
  bool _isSearching = false;

  // Mock Products Data
  final List<Map<String, dynamic>> _allProducts = [
    {
      "title": "Admisión de Aire Frío Mishimoto",
      "price": "\$349.99",
      "rating": "4.8",
      "category": "Motor",
      "imageUrl": 'assets/Aceites_motor_sintético_premium.jpg',
    },
    {
      "title": "Kit Serie GT Brembo",
      "price": "\$1,299.00",
      "rating": "5.0",
      "category": "Frenos",
      "imageUrl": "assets/Kit de Freno Completo Delantero.jpeg",
    },
    {
      "title": "Ohlins Carretera y Pista",
      "price": "\$2,450.00",
      "rating": "4.9",
      "category": "Suspensión",
      "imageUrl": "assets/Líquido de Frenos2.jpeg",
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredProducts = List.from(_allProducts);
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = List.from(_allProducts);
        _isSearching = false;
      } else {
        _isSearching = true;
        _filteredProducts = _allProducts.where((product) {
          final title = (product['title'] ?? '').toString().toLowerCase();
          final category = (product['category'] ?? '').toString().toLowerCase();
          final search = query.toLowerCase();
          return title.contains(search) || category.contains(search);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initialize styles
    // Initialize styles locally to rebuild safely
    final TextStyle kSubHeadingStyle = GoogleFonts.spaceGrotesk(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 1. Custom AppBar / Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('SPEED SPARES',
                                style: GoogleFonts.racingSansOne(
                                    fontSize: 28,
                                    color: kPrimaryAccent,
                                    fontStyle: FontStyle.italic)),
                            Text('Repuestos Premium',
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 12)),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartView(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: kSurfaceColor, shape: BoxShape.circle),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(Icons.shopping_bag_outlined,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MisPedidosView(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: kSurfaceColor, shape: BoxShape.circle),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(Icons.receipt_long_outlined,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Functional Search Bar
                    TextField(
                      controller: _searchCtrl,
                      onChanged: _filterProducts,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Busca repuestos (ej: Frenos)...',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        prefixIcon: Icon(Icons.search, color: kPrimaryAccent),
                        filled: true,
                        fillColor: kSurfaceColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.white10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.white10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: kPrimaryAccent),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Vehicle Selector (My Garage) - Hide when searching
            if (!_isSearching)
              SliverToBoxAdapter(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF212121), Color(0xFF2C2C2C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white12),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          offset: Offset(0, 4))
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.directions_car_filled,
                          color: kSecondaryAccent, size: 32),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('MI GARAJE',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 10,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('2024 Porsche 911 GT3',
                              style: GoogleFonts.spaceGrotesk(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.keyboard_arrow_down,
                          color: Colors.white54),
                    ],
                  ),
                ),
              ),

            // 3. Promotional Carousel - Hide when searching
            if (!_isSearching)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                  child: SizedBox(
                    height: 180,
                    child: PageView(
                      children: [
                        _buildPromoCard(
                            kPrimaryAccent,
                            "DESATA\nRENDIMIENTO PURO",
                            "20% DESC EN KITS TURBO",
                            "https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?auto=format&fit=crop&q=80"),
                        _buildPromoCard(
                            kSecondaryAccent,
                            "SISTEMAS DE FRENOS\nDE PISTA",
                            "MEJORA AHORA",
                            "https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?auto=format&fit=crop&q=80"),
                      ],
                    ),
                  ),
                ),
              ),

            // 4. Categories Grid - Hide when searching
            if (!_isSearching)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverToBoxAdapter(
                  child: Text('CATEGORÍAS', style: kSubHeadingStyle),
                ),
              ),
            if (!_isSearching)
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                  children: [
                    _buildCategoryItem(
                        "Motor", Icons.settings_suggest, kPrimaryAccent),
                    _buildCategoryItem(
                        "Frenos", Icons.disc_full, kSecondaryAccent),
                    _buildCategoryItem(
                        "Suspensión", Icons.import_export, Colors.amber),
                    _buildCategoryItem(
                        "Iluminación", Icons.highlight, Colors.purpleAccent),
                    _buildCategoryItem(
                        "Ruedas", Icons.tire_repair, Colors.cyan),
                    _buildCategoryItem(
                        "Escape", Icons.filter_list, Colors.orange),
                    _buildCategoryItem("Interior",
                        Icons.airline_seat_recline_extra, Colors.teal),
                    _buildCategoryItem("Fluidos", Icons.opacity, Colors.indigo),
                  ],
                ),
              ),

            // 5. Trending Now (Filtered List)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        _isSearching
                            ? 'RESULTADOS (\${_filteredProducts.length})'
                            : 'TENDENCIAS',
                        style: kSubHeadingStyle),
                    if (!_isSearching)
                      Text('Ver Todo', style: TextStyle(color: kPrimaryAccent)),
                  ],
                ),
              ),
            ),

            // Removed redundant/broken SliverGrid section to fix layout issues
            // The results are displayed in the section below
            SliverToBoxAdapter(
              child: Container(
                height: 240, // Height for cards
                margin: const EdgeInsets.only(bottom: 40),
                child: _filteredProducts.isEmpty
                    ? Center(
                        child: Text("No hay resultados",
                            style: TextStyle(color: Colors.grey[600])))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = _filteredProducts[index];
                          return _cardProducto(
                            product['title'],
                            product['price'],
                            product['rating'],
                            product['imageUrl'],
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoCard(
      Color accent, String title, String subtitle, String imageUrl) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: GoogleFonts.racingSansOne(
                    color: Colors.white,
                    fontSize: 24,
                    height: 1.1,
                    letterSpacing: 1)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  color: accent, borderRadius: BorderRadius.circular(8)),
              child: Text(subtitle,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CatalogView(categoryName: title),
              ),
            );
          },
          splashColor: color.withOpacity(0.3),
          highlightColor: color.withOpacity(0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(color: Colors.grey[400], fontSize: 11),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardProducto(
      String title, String price, String rating, String imageUrl) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductDetailView(),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2C2C),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: imageUrl.startsWith('assets/')
                        ? Image.asset(
                            imageUrl,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image,
                                  size: 40, color: Colors.grey);
                            },
                          )
                        : Image.network(
                            imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image,
                                  size: 40, color: Colors.grey);
                            },
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.spaceGrotesk(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(price,
                            style: const TextStyle(
                                color: Color(0xFF2979FF),
                                fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                size: 14, color: Colors.amber),
                            Text(rating,
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 12)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
