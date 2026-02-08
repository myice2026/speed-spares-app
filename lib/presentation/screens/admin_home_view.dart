import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'admin_inventory_view.dart';
import 'login_view.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({super.key});

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  // State Variables
  double _totalSales = 12500000;
  final currencyFormat =
      NumberFormat.currency(locale: 'es_CO', symbol: '\$', decimalDigits: 0);

  // Mock Recent Orders (Mutable for state changes)
  final List<Map<String, dynamic>> _recentOrders = [
    {
      "id": "#001",
      "client": "Yice",
      "total": 450000,
      "status": "Pendiente",
      "color": Colors.orange,
      "isLoading": false,
    },
    {
      "id": "#002",
      "client": "Carlos Pérez",
      "total": 280000,
      "status": "Enviado",
      "color": Colors.green,
      "isLoading": false,
    },
    {
      "id": "#003",
      "client": "Ana Gómez",
      "total": 120000,
      "status": "Pendiente",
      "color": Colors.orange,
      "isLoading": false,
    },
    {
      "id": "#004",
      "client": "Jorge López",
      "total": 850000,
      "status": "Pendiente",
      "color": Colors.orange,
      "isLoading": false,
    },
  ];

  Future<void> _dispatchOrder(int index) async {
    // 1. Set Loading State
    setState(() {
      _recentOrders[index]['isLoading'] = true;
    });

    // 2. Simulate Connection/Delay
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // 3. Update State (Status + Sales)
    setState(() {
      _recentOrders[index]['isLoading'] = false;
      _recentOrders[index]['status'] = "Enviado";
      _recentOrders[index]['color'] = Colors.green;

      // Add value to Total Sales
      _totalSales += _recentOrders[index]['total'];
    });

    // 4. Show Notification
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            Text("Notificación enviada a ${_recentOrders[index]['client']}"),
          ],
        ),
        backgroundColor: Colors.green[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color kBackgroundColor = Color(0xFF1E1E2C);
    const Color kCardColor = Color(0xFF2D2D44);
    const Color kAccentColor = Color(0xFFEC7E94);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.admin_panel_settings, color: kAccentColor),
            const SizedBox(width: 10),
            Text(
              "ADMIN DASHBOARD",
              style: GoogleFonts.spaceGrotesk(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white54),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
                (route) => false,
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI Cards Update
            Row(
              children: [
                // Formatted Sales Card
                _buildKPICard("Ventas Mes", currencyFormat.format(_totalSales),
                    Colors.greenAccent,
                    icon: Icons.attach_money),
                const SizedBox(width: 16),
                _buildKPICard("Pendientes", "5", Colors.orangeAccent,
                    icon: Icons.pending_actions),
              ],
            ),
            const SizedBox(height: 16),
            _buildKPICard("Usuarios Registrados", "148", Colors.blueAccent,
                fullWidth: true, icon: Icons.group),

            const SizedBox(height: 32),

            // Inventory Action
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.purple.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4))
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminInventoryView()));
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.inventory, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          "GESTIONAR INVENTARIO 📦",
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Recent Orders Header
            Text(
              "Pedidos Recientes",
              style: GoogleFonts.spaceGrotesk(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Enhanced Orders List
            ..._recentOrders.asMap().entries.map((entry) {
              final index = entry.key;
              final order = entry.value;
              final bool isPending = order['status'] == "Pendiente";
              final bool isLoading = order['isLoading'] == true;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kCardColor,
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border(left: BorderSide(color: order['color'], width: 4)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Order Info
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pedido ${order['id']}",
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              order['client'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat.format(order['total']),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        // Action Button
                        if (isLoading)
                          const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        else if (isPending)
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kAccentColor,
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                            ),
                            onPressed: () => _dispatchOrder(index),
                            icon: const Icon(Icons.local_shipping, size: 16),
                            label: const Text("DESPACHAR"),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.green),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.check,
                                    color: Colors.green, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  "Enviado",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),

                    // Status Footer
                    if (isPending)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Icon(Icons.circle, color: order['color'], size: 10),
                            const SizedBox(width: 6),
                            Text(
                              "Estado: ${order['status']}",
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 12),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              );
            }).toList(),

            // Bottom Spacing
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildKPICard(String title, String value, Color color,
      {bool fullWidth = false, required IconData icon}) {
    return Expanded(
      flex: fullWidth ? 1 : 1,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D44),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
                Icon(icon, color: color.withOpacity(0.5), size: 18),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.spaceGrotesk(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
