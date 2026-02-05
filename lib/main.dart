import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speed_spares_app/viewmodels/pedido_viewmodel.dart';
import 'package:speed_spares_app/viewmodels/taller_viewmodel.dart';
import 'viewmodels/producto_viewmodel.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'views/splash_view.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Aquí inyectamos los dos cerebros: Productos y Autenticación
        ChangeNotifierProvider(create: (_) => ProductoViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => PedidoViewModel()),
        ChangeNotifierProvider(create: (_) => TallerViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Speed Spares',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: SplashView(), // Splash screen como pantalla inicial
      ),
    );
  }
}