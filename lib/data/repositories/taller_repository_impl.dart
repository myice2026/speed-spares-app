
import '../../domain/entities/taller.dart';
import '../../domain/repositories/taller_repository.dart';
import '../datasources/remote/api_service.dart';

class TallerRepositoryImpl implements TallerRepository {
  final ApiService _apiService;

  TallerRepositoryImpl(this._apiService);

  @override
  Future<List<Taller>> getTalleres() async {
    return await _apiService.getTalleres();
  }
}
