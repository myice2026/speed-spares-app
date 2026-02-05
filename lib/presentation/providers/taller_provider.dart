
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/taller.dart';
import 'repository_providers.dart';

final talleresProvider = FutureProvider<List<Taller>>((ref) async {
  final repository = ref.watch(tallerRepositoryProvider);
  return repository.getTalleres();
});
