
import '../entities/producto.dart';

abstract class ProductRepository {
  Future<List<Producto>> getProductos();
  Future<void> crearProducto(Producto producto);
}
