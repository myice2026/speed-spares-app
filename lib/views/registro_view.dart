import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'home_view.dart';

class RegistroView extends StatefulWidget {
  @override
  _RegistroViewState createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  final nombreCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Crear Cuenta")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: nombreCtrl, decoration: InputDecoration(labelText: "Nombre Completo")),
            SizedBox(height: 10),
            TextField(controller: emailCtrl, decoration: InputDecoration(labelText: "Email")),
            SizedBox(height: 10),
            TextField(controller: passCtrl, decoration: InputDecoration(labelText: "Contraseña"), obscureText: true),
            SizedBox(height: 20),
            
            authVM.cargando
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      bool exito = await authVM.registrar(nombreCtrl.text, emailCtrl.text, passCtrl.text);
                      if (exito) {
                        Navigator.pushAndRemoveUntil(
                          context, 
                          MaterialPageRoute(builder: (_) => HomeView()), 
                          (route) => false
                        );
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