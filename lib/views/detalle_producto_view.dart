import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/producto.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../services/api_service.dart'; // Usaremos esto directo para simplificar

class DetalleProductoView extends StatefulWidget {
  final Producto producto;

  const DetalleProductoView({Key? key, required this.producto})
      : super(key: key);

  @override
  _DetalleProductoViewState createState() => _DetalleProductoViewState();
}

class _DetalleProductoViewState extends State<DetalleProductoView> {
  bool _comprando = false;

  // Función para realizar la compra
  void _comprar(BuildContext context) async {
    final usuario =
        Provider.of<AuthViewModel>(context, listen: false).usuarioActual;
    if (usuario == null) return;

    setState(() => _comprando = true);

    try {
      final api = ApiService();
      await api.crearPedido(usuario.id!, widget.producto.id!);

      // Mostrar éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('¡Compra realizada con éxito! 🚗'),
            backgroundColor: Colors.green),
      );
      Navigator.pop(context); // Volver al catálogo
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error al comprar'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _comprando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.producto.nombre)),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono gigante simulando imagen
            Center(
                child: Icon(Icons.car_repair, size: 150, color: Colors.grey)),
            SizedBox(height: 20),

            Text(widget.producto.nombre,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text("\$${widget.producto.precio}",
                style: TextStyle(fontSize: 24, color: Colors.green)),
            SizedBox(height: 20),
            Text("Descripción:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.producto.descripcion, style: TextStyle(fontSize: 16)),

            Spacer(),

            // Botón de Compra
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
                onPressed: _comprando ? null : () => _comprar(context),
                child: _comprando
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("COMPRAR AHORA",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
