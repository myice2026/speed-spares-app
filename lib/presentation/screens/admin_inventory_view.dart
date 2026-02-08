import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminInventoryView extends StatelessWidget {
  const AdminInventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color kBackgroundColor = Color(0xFF1E1E2C); // Dark Blue-Grey
    const Color kCardColor = Color(0xFF2D2D44);
    const Color kAccentColor = Color(0xFFEC7E94); // Brand Red

    // Mock Inventory Data
    final List<Map<String, dynamic>> inventory = [
      {"name": "Frenos Brembo", "stock": 12, "price": 450000},
      {"name": "Amortiguadores", "stock": 8, "price": 280000},
      {"name": "Batería Bosch", "stock": 5, "price": 320000},
      {"name": "Aceite Sintético", "stock": 24, "price": 85000},
      {"name": "Kit Embrague", "stock": 3, "price": 650000},
      {"name": "Faros LED", "stock": 15, "price": 120000},
    ];

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: Text(
          "GESTIÓN DE INVENTARIO",
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: inventory.length,
        itemBuilder: (context, index) {
          final item = inventory[index];
          final bool isLowStock = item['stock'] < 5;

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kCardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isLowStock ? Colors.redAccent : Colors.white10,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.inventory_2_outlined,
                    color: isLowStock ? Colors.redAccent : kAccentColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "\$${item['price']}",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${item['stock']} unid.",
                      style: TextStyle(
                        color: isLowStock ? Colors.redAccent : Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isLowStock)
                      const Text(
                        "Stock Bajo",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 10,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Función 'Agregar' próximamente")),
          );
        },
        backgroundColor: kAccentColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
