
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/remote/api_service.dart';
import '../../data/datasources/remote/auth_service.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/repositories/taller_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/taller_repository.dart';

// Data Sources
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// Repositories
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(authServiceProvider));
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(ref.watch(apiServiceProvider));
});

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepositoryImpl(ref.watch(apiServiceProvider));
});

final tallerRepositoryProvider = Provider<TallerRepository>((ref) {
  return TallerRepositoryImpl(ref.watch(apiServiceProvider));
});
