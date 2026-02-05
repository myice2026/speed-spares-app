import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/order_provider.dart';

class MisPedidosView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // userOrdersProvider reads authProvider inside, so it reacts to user changes automatically
    final pedidosAsync = ref.watch(userOrdersProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Historial de Compras")),
      body: pedidosAsync.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Error: $err")),
          data: (pedidos) {
            return pedidos.isEmpty
                ? Center(child: Text("Aún no has comprado nada 🛒"))
                : ListView.builder(
                    itemCount: pedidos.length,
                    itemBuilder: (context, index) {
                      final pedido = pedidos[index];
                      return Card(
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(Icons.check, color: Colors.white),
                          ),
                          title: Text(pedido.nombreProducto ?? "Desconocido",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              "Estado: ${pedido.estado}\nFecha: ${pedido.fecha.substring(0, 10)}"),
                          trailing: Text("\$${pedido.precio ?? 0}",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.blue)),
                        ),
                      );
                    },
                  );
          }),
    );
  }
}
