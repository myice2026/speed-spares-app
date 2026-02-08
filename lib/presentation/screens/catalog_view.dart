import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_detail_view.dart';

class CatalogView extends StatelessWidget {
  final String categoryName;

  const CatalogView({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // Theme Constants
    const Color kBackgroundColor = Color(0xFF121212);
    const Color kSurfaceColor = Color(0xFF1E1E1E);
    const Color kPrimaryAccent = Color(0xFF2979FF);

    // Mock Data (Expanded for Catalog)
    final List<Map<String, dynamic>> allProducts = [
      {
        "title": "Admisión de Aire Frío Mishimoto",
        "price": "\$349.99",
        "rating": "4.8",
        "category": "Motor",
        "image":
            "https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?auto=format&fit=crop&q=80"
      },
      {
        "title": "Kit Serie GT Brembo",
        "price": "\$1,299.00",
        "rating": "5.0",
        "category": "Frenos",
        "image":
            "https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?auto=format&fit=crop&q=80"
      },
      {
        "title": "Ohlins Carretera y Pista",
        "price": "\$2,450.00",
        "rating": "4.9",
        "category": "Suspensión",
        "image":
            "https://images.unsplash.com/photo-1517524008697-84bbe3c3fd98?auto=format&fit=crop&q=80"
      },
      {
        "title": "Escape Akrapovic Titanium",
        "price": "\$3,450.00",
        "rating": "5.0",
        "category": "Escape",
        "image":
            "https://images.unsplash.com/photo-1542282088-fe8426682b8f?auto=format&fit=crop&q=80"
      },
      {
        "title": "Luces LED Philips Ultinon",
        "price": "\$120.00",
        "rating": "4.5",
        "category": "Iluminación",
        "image":
            "https://images.unsplash.com/photo-1485664147043-41bb33388703?auto=format&fit=crop&q=80"
      },
      {
        "title": "Pastillas Cerámicas",
        "price": "\$89.99",
        "rating": "4.7",
        "category": "Frenos",
        "image":
            "https://images.unsplash.com/photo-1600705722908-bab1e61c0b4d?auto=format&fit=crop&q=80"
      },
    ];

    // Filter products
    final displayProducts =
        allProducts.where((p) => p['category'] == categoryName).toList();

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Categoría: $categoryName',
          style: GoogleFonts.spaceGrotesk(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: displayProducts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2_outlined,
                      size: 64, color: Colors.grey[800]),
                  const SizedBox(height: 16),
                  Text(
                    "No hay productos en esta categoría aún.",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7, // Taller cards
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: displayProducts.length,
                itemBuilder: (context, index) {
                  final product = displayProducts[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: kSurfaceColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
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
                            flex: 3,
                            child: Container(
                              color: Colors.white10,
                              child: Center(
                                child: Icon(Icons.build_circle_outlined,
                                    size: 64, color: Colors.grey[700]),
                                // Placeholder until network images logic is verified or just use icon for safety
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['title'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.spaceGrotesk(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    product['price'],
                                    style: TextStyle(
                                      color: kPrimaryAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ProductDetailView(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kPrimaryAccent,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0),
                                        minimumSize: const Size(0, 32),
                                      ),
                                      child: const Text("Ver",
                                          style: TextStyle(fontSize: 12)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
