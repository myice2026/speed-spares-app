import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/taller_viewmodel.dart';

class TalleresView extends StatefulWidget {
  @override
  _TalleresViewState createState() => _TalleresViewState();
}

class _TalleresViewState extends State<TalleresView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TallerViewModel>(context, listen: false).cargarTalleres();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TallerViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Talleres Aliados")),
      body: vm.cargando
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: vm.talleres.length,
              itemBuilder: (context, index) {
                final taller = vm.talleres[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Icon(Icons.location_on, color: Colors.red, size: 40),
                    title: Text(taller.nombre, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(taller.direccion),
                    trailing: ElevatedButton.icon(
                      icon: Icon(Icons.map, size: 18),
                      label: Text("Ir"),
                      onPressed: () {
                        vm.abrirMapa(taller.latitud, taller.longitud);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}