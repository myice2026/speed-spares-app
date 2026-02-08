import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerDashboardView extends StatelessWidget {
  const SellerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color kBackgroundColor = Color(0xFF121212);
    const Color kSurfaceColor = Color(0xFF1E1E1E);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: Text(
          "Tablero del Vendedor",
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Financial Summary Cards
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Ventas Totales",
                    "\$4.500.000",
                    Colors.greenAccent,
                    Icons.attach_money,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    "Prod. Activos",
                    "12",
                    Colors.lightBlueAccent,
                    Icons.inventory_2_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildSummaryCard(
              "Pedidos por Despachar",
              "3",
              Colors.orangeAccent,
              Icons.local_shipping_outlined,
              isAlert: true,
            ),
            const SizedBox(height: 32),

            // Sales Chart (Simulated)
            Text(
              "Crecimiento de Ventas (6 Meses)",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kSurfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildBar("Ago", 0.4),
                  _buildBar("Sep", 0.5),
                  _buildBar("Oct", 0.3),
                  _buildBar("Nov", 0.7),
                  _buildBar("Dic", 0.9),
                  _buildBar("Ene", 0.6),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Recent Sales List
            Text(
              "Ventas Recientes",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildRecentSaleItem("Amortiguadores Delanteros", "Hace 2 horas",
                "+\$250.000", Colors.green),
            _buildRecentSaleItem("Aceite Sintético 5W-30", "Hace 5 horas",
                "+\$85.000", Colors.green),
            _buildRecentSaleItem(
                "Filtro de Aire", "Ayer", "+\$45.000", Colors.green),
            _buildRecentSaleItem(
                "Reembolso: Pastillas", "Ayer", "-\$120.000", Colors.redAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
      String title, String value, Color color, IconData icon,
      {bool isAlert = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: isAlert ? color.withOpacity(0.5) : Colors.white10,
            width: isAlert ? 2 : 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String label, double heightPct) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 20,
          height: 150 * heightPct,
          decoration: BoxDecoration(
            color: const Color(0xFFEC7E94),
            borderRadius: BorderRadius.circular(4),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                const Color(0xFFEC7E94).withOpacity(0.3),
                const Color(0xFFEC7E94),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildRecentSaleItem(
      String title, String time, String amount, Color amountColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Text(
            amount,
            style: TextStyle(
              color: amountColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
