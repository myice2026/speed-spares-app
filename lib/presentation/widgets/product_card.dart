import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/producto.dart';

class ProductCard extends StatelessWidget {
  final Producto producto;
  final VoidCallback onTap;

  const ProductCard({
    Key? key,
    required this.producto,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color kPrimaryColor = Color(0xFF2962FF);

    Widget getImage() {
      if (producto.imagenPrincipalUrl != null &&
          producto.imagenPrincipalUrl!.isNotEmpty) {
        final String url = producto.imagenPrincipalUrl!;
        
        if (url.startsWith('assets/')) {
          return Image.asset(
            url,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 40, color: Colors.grey);
            },
          );
        } else {
          return Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 40, color: Colors.grey);
            },
          );
        }
      }
      return const Icon(Icons.category_outlined, size: 40, color: Colors.grey);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: getImage(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    producto.nombre,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${producto.precio.toStringAsFixed(2)}',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
