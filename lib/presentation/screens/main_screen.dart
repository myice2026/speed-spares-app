import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_view.dart';
import 'mis_pedidos_view.dart';
import 'profile_view.dart';
import 'productos_view.dart';

class MainScreen extends ConsumerStatefulWidget {
  final String email;
  const MainScreen({super.key, required this.email});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _currentIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Initialize pages with dynamic data
    _pages = [
      const HomeView(),
      const ProductosView(), // Productos desde backend
      const MisPedidosView(),
      ProfileView(email: widget.email),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Theme Constants
    const Color kBackgroundColor = Color(0xFF121212);
    const Color kSurfaceColor = Color(0xFF1E1E1E);
    const Color kPrimaryAccent = Color(0xFF2979FF);
    const Color kSecondaryAccent = Color(0xFFEC7E94);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white10)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: kSurfaceColor,
          selectedItemColor: kSecondaryAccent,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_filled),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined),
              activeIcon: Icon(Icons.storefront),
              label: 'Productos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping_outlined),
              activeIcon: Icon(Icons.local_shipping),
              label: 'Pedidos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
