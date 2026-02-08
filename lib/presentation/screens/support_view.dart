import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color kBackgroundColor = Color(0xFF121212);
    const Color kSurfaceColor = Color(0xFF1E1E1E);
    const Color kPrimaryRed = Color(0xFFEC7E94);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: Text(
          "Centro de Ayuda",
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
            // Header
            Text(
              "Centro de Ayuda Speed Spares",
              style: GoogleFonts.spaceGrotesk(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Estamos para ayudarte en cualquier momento",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),

            // Contact Channels
            _buildSectionTitle("Canales de Atención"),
            const SizedBox(height: 16),
            _buildContactOption(
              context,
              icon: Icons.chat_bubble_outline, // Simulate WhatsApp icon
              color: Colors.greenAccent,
              title: "WhatsApp",
              subtitle: "313 433 7687 (Soporte Rápido)",
              actionText: "Chatear",
            ),
            _buildContactOption(
              context,
              icon: Icons.phone_outlined,
              color: Colors.blueAccent,
              title: "Llamada",
              subtitle: "Línea Nacional 313 433 7687",
              actionText: "Llamar",
            ),
            _buildContactOption(
              context,
              icon: Icons.email_outlined,
              color: kPrimaryRed,
              title: "Correo Electrónico",
              subtitle: "speedsparesco@gmail.com",
              actionText: "Enviar",
            ),

            const SizedBox(height: 40),

            // Social Media
            _buildSectionTitle("Síguenos para descuentos"),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSocialCard(
                    context,
                    icon: Icons.camera_alt_outlined, // Simulate Instagram
                    name: "@speed_spares.co",
                    color: Colors.purpleAccent,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSocialCard(
                    context,
                    icon: Icons.facebook,
                    name: "/speedsparesco",
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildContactOption(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String actionText,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Abriendo $title..."),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[700]),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialCard(
    BuildContext context, {
    required IconData icon,
    required String name,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Abriendo red social..."),
            duration: Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
