import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart'; // Ensure this package is available
import '../providers/taller_provider.dart';

class TalleresView extends ConsumerWidget {
  void abrirMapa(BuildContext context, double lat, double lng) async {
    final googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
    final uri = Uri.parse(googleMapsUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("No se pudo abrir el mapa")));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final talleresAsync = ref.watch(talleresProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Talleres Aliados")),
      body: talleresAsync.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Error: $err")),
          data: (talleres) {
            return ListView.builder(
              itemCount: talleres.length,
              itemBuilder: (context, index) {
                final taller = talleres[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading:
                        Icon(Icons.location_on, color: Colors.red, size: 40),
                    title: Text(taller.nombre,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(taller.direccion),
                    trailing: ElevatedButton.icon(
                      icon: Icon(Icons.map, size: 18),
                      label: Text("Ir"),
                      onPressed: () {
                        abrirMapa(context, taller.latitud, taller.longitud);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
