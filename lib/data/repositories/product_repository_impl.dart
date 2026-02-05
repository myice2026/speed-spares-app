
import '../../domain/entities/producto.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/remote/api_service.dart';
import '../models/producto.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiService _apiService;

  ProductRepositoryImpl(this._apiService);

  @override
  Future<List<Producto>> getProductos() async {
    return await _apiService.getProductos();
  }

  @override
  Future<void> crearProducto(Producto producto) async {
    final productoModel = ProductoModel(
      id: producto.id,
      nombre: producto.nombre,
      descripcion: producto.descripcion,
      precio: producto.precio,
    );
    await _apiService.crearProducto(productoModel);
  }
}
