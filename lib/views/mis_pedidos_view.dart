import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/pedido_viewmodel.dart';
import '../viewmodels/auth_viewmodel.dart';

class MisPedidosView extends StatefulWidget {
  @override
  _MisPedidosViewState createState() => _MisPedidosViewState();
}

class _MisPedidosViewState extends State<MisPedidosView> {
  @override
  void initState() {
    super.initState();
    // Al abrir la pantalla, buscamos el ID del usuario y pedimos sus compras
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final usuario = Provider.of<AuthViewModel>(context, listen: false).usuarioActual;
      if (usuario != null) {
        Provider.of<PedidoViewModel>(context, listen: false).cargarPedidos(usuario.id!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PedidoViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Historial de Compras")),
      body: vm.cargando
          ? Center(child: CircularProgressIndicator())
          : vm.pedidos.isEmpty
              ? Center(child: Text("Aún no has comprado nada 🛒"))
              : ListView.builder(
                  itemCount: vm.pedidos.length,
                  itemBuilder: (context, index) {
                    final pedido = vm.pedidos[index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(Icons.check, color: Colors.white),
                        ),
                        title: Text(pedido.nombreProducto, style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("Estado: ${pedido.estado}\nFecha: ${pedido.fecha.substring(0, 10)}"),
                        trailing: Text("\$${pedido.precio}", style: TextStyle(fontSize: 16, color: Colors.blue)),
                      ),
                    );
                  },
                ),
    );
  }
}