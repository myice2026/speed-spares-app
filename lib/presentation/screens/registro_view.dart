import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'home_view.dart';

class RegistroView extends ConsumerStatefulWidget {
  @override
  _RegistroViewState createState() => _RegistroViewState();
}

class _RegistroViewState extends ConsumerState<RegistroView> {
  final nombreCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Crear Cuenta")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: nombreCtrl,
                decoration: InputDecoration(labelText: "Nombre Completo")),
            SizedBox(height: 10),
            TextField(
                controller: emailCtrl,
                decoration: InputDecoration(labelText: "Email")),
            SizedBox(height: 10),
            TextField(
                controller: passCtrl,
                decoration: InputDecoration(labelText: "Contraseña"),
                obscureText: true),
            SizedBox(height: 10),
            if (authState.errorMessage != null)
              Text(authState.errorMessage!,
                  style: TextStyle(color: Colors.red)),
            SizedBox(height: 20),
            authState.isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      final success = await ref
                          .read(authProvider.notifier)
                          .register(
                              nombreCtrl.text, emailCtrl.text, passCtrl.text);
                      if (success) {
                        if (!mounted) return;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => HomeView()),
                            (route) => false);
                      }
                    },
                    child: Text("REGISTRARSE"),
                  )
          ],
        ),
      ),
    );
  }
}
