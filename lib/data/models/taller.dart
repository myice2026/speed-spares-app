
import '../../domain/entities/taller.dart';

class TallerModel extends Taller {
  const TallerModel({
    int? id,
    required String nombre,
    required String direccion,
    required String telefono, // Added missing field
    required double latitud,
    required double longitud,
  }) : super(
          id: id,
          nombre: nombre,
          direccion: direccion,
          telefono: telefono,
          latitud: latitud,
          longitud: longitud,
        );

  factory TallerModel.fromJson(Map<String, dynamic> json) {
    return TallerModel(
      id: json['id'],
      nombre: json['nombre'],
      direccion: json['direccion'],
      telefono: json['telefono'] ?? '', // Handle potential null
      latitud: (json['latitud'] as num).toDouble(),
      longitud: (json['longitud'] as num).toDouble(),
    );
  }
}