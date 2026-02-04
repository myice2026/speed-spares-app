import 'package:flutter/material.dart';
import '../models/taller.dart';
import '../services/api_service.dart';
import 'package:url_launcher/url_launcher.dart'; // Para abrir el mapa

class TallerViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();
  List<Taller> _talleres = [];
  bool _cargando = false;

  List<Taller> get talleres => _talleres;
  bool get cargando => _cargando;

  Future<void> cargarTalleres() async {
    _cargando = true;
    notifyListeners();
    try {
      _talleres = await _api.getTalleres();
    } catch (e) {
      print(e);
    }
    _cargando = false;
    notifyListeners();
  }

  // Función mágica para abrir Google Maps
  Future<void> abrirMapa(double lat, double lng) async {
    final Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('No se pudo abrir el mapa');
    }
  }
}