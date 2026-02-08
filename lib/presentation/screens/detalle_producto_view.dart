import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/producto.dart';
import '../providers/auth_provider.dart';
import '../providers/order_provider.dart';

class DetalleProductoView extends ConsumerStatefulWidget {
  final Producto producto;

  const DetalleProductoView({Key? key, required this.producto})
      : super(key: key);

  @override
  ConsumerState<DetalleProductoView> createState() =>
      _DetalleProductoViewState();
}

class _DetalleProductoViewState extends ConsumerState<DetalleProductoView> {
  // Función para realizar la compra
  void _comprar(BuildContext context) async {
    final authState = ref.read(authProvider);
    final usuario = authState.usuario;

    if (usuario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Debes iniciar sesión para comprar'),
          backgroundColor: Colors.red[700],
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    await ref
        .read(orderActionsProvider.notifier)
        .createOrder(widget.producto.id!);

    final orderState = ref.read(orderActionsProvider);

    if (!mounted) return;

    orderState.when(
      data: (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 10),
                Expanded(child: Text('¡Compra realizada con éxito! 🚗')),
              ],
            ),
            backgroundColor: Colors.green[700],
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
        Navigator.pop(context); // Volver al catálogo
      },
      loading: () {}, // Handled by UI blocking
      error: (e, st) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al comprar: $e'),
            backgroundColor: Colors.red[700],
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderActionsProvider);
    final bool comprando = orderState is AsyncLoading;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50], // Fondo sutil
      appBar: AppBar(
        title: const Text("Detalle del Producto"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black, // Iconos oscuros
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen Hero / Placeholder Mejorado
                  Hero(
                    tag:
                        'product_${widget.producto.id}', // Si usas Hero en la lista, esto animará
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.car_repair,
                            size: 100,
                            color: theme.primaryColor.withValues(alpha: 0.2),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 20,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "Repuesto Original",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Título y Precio
                  Text(
                    widget.producto.nombre,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${widget.producto.precio.toStringAsFixed(2)}",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.primaryColor,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Descripción
                  Text(
                    "Descripción",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.producto.descripcion,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // Barra inferior de acción
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 56, // Altura estándar Material 3
                child: FilledButton(
                  onPressed: comprando ? null : () => _comprar(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    disabledBackgroundColor:
                        theme.primaryColor.withValues(alpha: 0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: comprando
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart_checkout),
                              SizedBox(width: 8),
                              Text(
                                "COMPRAR AHORA",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
