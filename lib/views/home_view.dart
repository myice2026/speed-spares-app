import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speed_spares_app/views/talleres_view.dart';
import '../viewmodels/producto_viewmodel.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'detalle_producto_view.dart';
import 'mis_pedidos_view.dart';
import 'login_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // Apenas carga la pantalla, pedimos la lista de productos
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductoViewModel>(context, listen: false).cargarProductos();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos acceso a los ViewModels
    final productVM = Provider.of<ProductoViewModel>(context);
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      // --- APPBAR CON BUSCADOR (MODIFICADO) ---
      appBar: AppBar(
        title: Text('Speed Spares - Catálogo'),
        // Aquí agregamos la barra de búsqueda fija
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar repuesto (ej. Bujía)...",
                prefixIcon: Icon(Icons.search),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (texto) {
                // LLAMAMOS AL MÉTODO BUSCAR DEL VIEWMODEL
                productVM.buscar(texto);
              },
            ),
          ),
        ),
      ),

      // --- MENÚ LATERAL (DRAWER) ---
      // (Este bloque está igual que en tu código, no lo toqué)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle, size: 60, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    authVM.usuarioActual?.nombreCompleto ?? "Usuario",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text('Mis Pedidos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => MisPedidosView()));
              },
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Talleres Aliados'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => TalleresView()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Cerrar Sesión'),
              onTap: () {
                authVM.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginView()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),

      // --- CUERPO DE LA PANTALLA ---
      body: productVM.cargando
          ? Center(child: CircularProgressIndicator())
          : productVM.mensajeError.isNotEmpty
              ? Center(child: Text(productVM.mensajeError, style: TextStyle(color: Colors.red)))
              // Validamos si la lista está vacía después de buscar
              : productVM.productos.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 60, color: Colors.grey),
                          Text("No se encontraron resultados", style: TextStyle(fontSize: 18, color: Colors.grey)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: productVM.productos.length,
                      itemBuilder: (context, index) {
                        final prod = productVM.productos[index];
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          elevation: 3,
                          child: ListTile(
                            leading: Icon(Icons.car_repair, size: 40, color: Colors.blue),
                            title: Text(prod.nombre, style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text("\$${prod.precio} - ${prod.descripcion}"),
                            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetalleProductoView(producto: prod),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
    );
  }
}