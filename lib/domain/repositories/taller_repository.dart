
import '../entities/taller.dart';

abstract class TallerRepository {
  Future<List<Taller>> getTalleres();
}
