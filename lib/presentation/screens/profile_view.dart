import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_view.dart';
import 'edit_profile_view.dart';
import 'payment_methods_view.dart';
import 'publish_product_view.dart';
import 'seller_dashboard_view.dart';
import 'support_view.dart';

class ProfileView extends StatelessWidget {
  final String email;
  const ProfileView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    // Theme Constants
    const Color kBackgroundColor = Color(0xFF121212);
    const Color kSurfaceColor = Color(0xFF1E1E1E);
    const Color kPrimaryAccent = Color(0xFF2979FF);
    const Color kSecondaryAccent = Color(0xFFEC7E94);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // User Avatar
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: kSecondaryAccent, width: 2),
                  image: DecorationImage(
                    image: NetworkImage(email == "yice@test.com"
                        ? "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80"
                        : "https://images.unsplash.com/photo-1599566150163-29194dcaad36?auto=format&fit=crop&q=80"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // User Name
              Text(
                email == "yice@test.com" ? "Yice" : email.split('@')[0],
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                email,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),

              // Vehicle Card
              Container(
                width: double.infinity,
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
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: kSurfaceColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Icon(Icons.directions_car_filled,
                          color: kSecondaryAccent, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('MI VEHÍCULO',
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 10,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Porsche 911 GT3',
                            style: GoogleFonts.spaceGrotesk(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        Text('2024',
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Seller Action
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PublishProductView()),
                    );
                  },
                  icon:
                      const Icon(Icons.sell_outlined, color: kSecondaryAccent),
                  label: const Text(
                    "Vender un Repuesto",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kSecondaryAccent,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: kSecondaryAccent, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              // Seller Dashboard Link
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SellerDashboardView()),
                    );
                  },
                  icon: const Icon(Icons.bar_chart, color: Colors.white),
                  label: const Text(
                    "VER ESTADÍSTICAS DE VENTAS",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        Colors.blueAccent, // Distinctive Blue Color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              // Options List

              _buildProfileOption(
                context,
                Icons.edit_outlined,
                "Editar Perfil",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfileView()),
                  );
                },
              ),
              _buildProfileOption(
                context,
                Icons.credit_card,
                "Métodos de Pago",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentMethodsView()),
                  );
                },
              ),
              _buildProfileOption(
                context,
                Icons.headset_mic_outlined,
                "Soporte",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SupportView()),
                  );
                },
              ),
              _buildProfileOption(
                context,
                Icons.logout,
                "Cerrar Sesión",
                isDestructive: true,
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context, IconData icon, String title,
      {bool isDestructive = false, VoidCallback? onTap}) {
    const Color kSurfaceColor = Color(0xFF1E1E1E);
    const Color kSecondaryAccent = Color(0xFFEC7E94);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        leading:
            Icon(icon, color: isDestructive ? kSecondaryAccent : Colors.white),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? kSecondaryAccent : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white54),
        onTap: onTap ??
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      "Funcionalidad disponible en la próxima actualización"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
      ),
    );
  }
}
