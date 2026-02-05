import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'home_view.dart';
import 'registro_view.dart'; // Crearemos esta pantalla abajo

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

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
              if (authVM.mensajeError.isNotEmpty)
                Text(authVM.mensajeError, style: TextStyle(color: Colors.red)),

              SizedBox(height: 20),
              
              // Botón de Entrar
              authVM.cargando
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        bool exito = await authVM.login(emailCtrl.text, passCtrl.text);
                        if (exito) {
                          // Navegar al Home si el login es correcto
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