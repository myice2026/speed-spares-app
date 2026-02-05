
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'home_view.dart';
import 'registro_view.dart';

class LoginView extends ConsumerStatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // Listen to changes for side effects (navigation) could be done here or in onPressed, 
    // but simple bool check in onPressed is fine for now as previously implemented.
    // Ideally we'd use ref.listen.

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/LOGO_SPEED_SPARES_(3)[1].jpg',
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 20),
                Text("Speed Spares", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 30),
              
              // Campos de texto
              TextField(
                controller: emailCtrl,
                decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              TextField(
                controller: passCtrl,
                decoration: InputDecoration(labelText: "Contraseña", border: OutlineInputBorder()),
                obscureText: true,
              ),
              
              SizedBox(height: 20),
              
              // Mensaje de error si falla
              if (authState.errorMessage != null)
                Text(authState.errorMessage!, style: TextStyle(color: Colors.red)),

              SizedBox(height: 20),
              
              // Botón de Entrar
              authState.isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        final success = await ref.read(authProvider.notifier).login(emailCtrl.text, passCtrl.text);
                        if (success) {
                          // Navegar al Home si el login es correcto
                          if (!mounted) return;
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeView()));
                        }
                      },
                      child: Text("INGRESAR"),
                      style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
                    ),

              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (_) => RegistroView()));
                },
                child: Text("¿No tienes cuenta? Regístrate"),
              )
            ],
            ),
          ),
        ),
      ),
    );
  }
}