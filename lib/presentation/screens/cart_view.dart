import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'checkout_view.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  // Theme Constants
  final Color kBackgroundColor = const Color(0xFF121212);
  final Color kSurfaceColor = const Color(0xFF1E1E1E);
  final Color kPrimaryAccent = const Color(0xFFEC7E94); // Racing Red
  final Color kSecondaryBlue = const Color(0xFF2979FF); // Electric Blue

  // State for Delivery Selector
  bool _isDelivery = true; // true = Domicilio, false = Recoger en Tienda

  // Mock Data
  final List<Map<String, dynamic>> _cartItems = [
    {
      "name": "Kit Turbo A45",
      "price": 3500000.0, // COP
      "quantity": 1,
      "image":
          "https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?auto=format&fit=crop&q=80"
    },
    {
      "name": "Pastillas Frenos Brembo",
      "price": 450000.0,
      "quantity": 2,
      "image":
          "https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?auto=format&fit=crop&q=80"
    },
    {
      "name": "Aceite Sintético 5W-30",
      "price": 85000.0,
      "quantity": 1,
      "image":
          "https://plus.unsplash.com/premium_photo-1661380552787-8d0092c6b41d?q=80&w=2970&auto=format&fit=crop"
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Calculations
    double subtotal = 0;
    for (var item in _cartItems) {
      subtotal += (item['price'] as double) * (item['quantity'] as int);
    }

    // Shipping Cost Logic
    double shippingCost = _isDelivery ? 15000.0 : 0.0;
    double total = subtotal + shippingCost;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Carrito de Compras',
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. List of Items
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: _cartItems.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return _buildCartItem(item, index);
              },
            ),
          ),

          // 2. Delivery Selector & Summary
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: kSurfaceColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Delivery Toggle
                _buildDeliverySelector(),
                const SizedBox(height: 24),

                // Financial Summary
                _buildSummaryRow("Subtotal", subtotal),
                const SizedBox(height: 8),
                _buildSummaryRow(
                  "Envío",
                  shippingCost,
                  isFree: shippingCost == 0 && _isDelivery == false,
                ),
                const Divider(color: Colors.white10, height: 32),
                _buildSummaryRow("TOTAL", total, isTotal: true),

                const SizedBox(height: 24),

                // Checkout Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CheckoutView(totalAmount: total),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                      shadowColor: kPrimaryAccent.withOpacity(0.4),
                    ),
                    child: Text(
                      "FINALIZAR COMPRA",
                      style: GoogleFonts.racingSansOne(
                        fontSize: 18,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item['image'],
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 80,
                height: 80,
                color: Colors.grey[800],
                child: const Icon(Icons.broken_image, color: Colors.white54),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "\$${(item['price'] as double).toStringAsFixed(0)}",
                  style: GoogleFonts.spaceGrotesk(
                    color: kPrimaryAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Quantity Controls
          Container(
            decoration: BoxDecoration(
              color: kSurfaceColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                _buildQtyBtn(Icons.remove, () {
                  if (item['quantity'] > 1) {
                    setState(() {
                      item['quantity']--;
                    });
                  }
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "${item['quantity']}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildQtyBtn(Icons.add, () {
                  setState(() {
                    item['quantity']++;
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Icon(icon, color: Colors.grey[400], size: 16),
      ),
    );
  }

  Widget _buildDeliverySelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildSelectorOption(
              "Envío a Domicilio",
              Icons.local_shipping_outlined,
              _isDelivery,
              () => setState(() => _isDelivery = true),
            ),
          ),
          Expanded(
            child: _buildSelectorOption(
              "Recoger en Tienda",
              Icons.storefront_outlined,
              !_isDelivery,
              () => setState(() => _isDelivery = false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectorOption(
      String label, IconData icon, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? kPrimaryAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : Colors.grey[500],
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[500],
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value,
      {bool isTotal = false, bool isFree = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? Colors.white : Colors.grey[500],
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          isFree ? "GRATIS" : "\$${value.toStringAsFixed(0)}",
          style: GoogleFonts.spaceGrotesk(
            color: isTotal ? kPrimaryAccent : Colors.white,
            fontSize: isTotal ? 22 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
