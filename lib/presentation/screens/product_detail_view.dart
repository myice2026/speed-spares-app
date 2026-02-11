import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/producto.dart';

class ProductDetailView extends StatelessWidget {
  final Producto? producto;

  const ProductDetailView({super.key, this.producto});

  @override
  Widget build(BuildContext context) {
    const Color kBackgroundColor = Color(0xFFF5F5F7);
    const Color kPrimaryColor = Color(0xFF2962FF);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Detalles',
          style: GoogleFonts.outfit(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: producto == null
          ? const Center(child: Text('Producto no encontrado'))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen del producto (con Hero)
                  Container(
                    width: double.infinity,
                    height: 300,
                    color: Colors.white,
                    child: Hero(
                      tag: 'product_image_${producto!.id}',
                      child: producto?.imagenPrincipalUrl != null &&
                              producto!.imagenPrincipalUrl!.isNotEmpty
                          ? Image.network(
                              producto!.imagenPrincipalUrl!,
                              fit: BoxFit.contain,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  Center(
                                child: Icon(Icons.broken_image_outlined,
                                    size: 64, color: Colors.grey[300]),
                              ),
                            )
                          : Center(
                              child: Icon(Icons.inventory_2_outlined,
                                  size: 80, color: Colors.grey[300]),
                            ),
                    ),
                  ),

                  // Información del producto
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SKU tag
                                  if (producto?.sku != null)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        'SKU: ${producto!.sku}',
                                        style: GoogleFonts.outfit(
                                          color: Colors.grey[700],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  const SizedBox(height: 12),
                                  Text(
                                    producto!.nombre,
                                    style: GoogleFonts.outfit(
                                      color: Colors.black87,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              '\$${producto!.precio.toStringAsFixed(2)}',
                              style: GoogleFonts.outfit(
                                color: kPrimaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Stock Indicator
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: producto!.cantidadStock != null &&
                                    producto!.cantidadStock! > 0
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: producto!.cantidadStock != null &&
                                      producto!.cantidadStock! > 0
                                  ? Colors.green.withOpacity(0.3)
                                  : Colors.red.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                producto!.cantidadStock != null &&
                                        producto!.cantidadStock! > 0
                                    ? Icons.check_circle_outline
                                    : Icons.error_outline,
                                size: 16,
                                color: producto!.cantidadStock != null &&
                                        producto!.cantidadStock! > 0
                                    ? Colors.green[700]
                                    : Colors.red[700],
                              ),
                              const SizedBox(width: 8),
                              Text(
                                producto!.cantidadStock != null &&
                                        producto!.cantidadStock! > 0
                                    ? 'Disponible (${producto!.cantidadStock} unidades)'
                                    : 'Agotado',
                                style: GoogleFonts.outfit(
                                  color: producto!.cantidadStock != null &&
                                          producto!.cantidadStock! > 0
                                      ? Colors.green[700]
                                      : Colors.red[700],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Descripción
                        Text(
                          'Descripción',
                          style: GoogleFonts.outfit(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          producto!.descripcion ??
                              'No hay descripción disponible para este producto.',
                          style: GoogleFonts.outfit(
                            color: Colors.grey[600],
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        if (producto!.descripcionLarga != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            producto!.descripcionLarga!,
                            style: GoogleFonts.outfit(
                              color: Colors.grey[600],
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed:
                producto?.cantidadStock != null && producto!.cantidadStock! > 0
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Añadido al carrito (Simulado)")),
                        );
                      }
                    : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              'Agregar al Carrito',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
