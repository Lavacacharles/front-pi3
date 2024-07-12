import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart';
import 'signup.dart';
import '../Navigatorview/Navigatorview.dart';
//import 'package:go_router/go_router.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  void testlogin(BuildContext context) async{
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Navigatorview()),
    );
  }
  void login(String username, String password, BuildContext context) async {
    try {
//hg
      var url = Uri.parse('http://10.0.2.2:8000/log/in');
      var response = await http.post(
        url = url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );
      //var response = await http.get(
      //  url = url);

      if (response.statusCode == 200) {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Navigatorview()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid username or password')),
        );
      }
    } catch (e) {
      print("Error during login: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed due to an error: $e')),
      );
    }
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Welcome Screen'),
      ),
      body: Stack(

          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/backgroud-1rst.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 100.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/image/logoFinal.png',
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(usernameController, 'Usuario'),
                    const SizedBox(height: 20),
                    _buildTextField(passwordController, 'Contraseña', isObscure: true),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        print("start db request");
                        //login(usernameController.text, passwordController.text, context);
                        testlogin(context);
                        print("end db request");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff110f26),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: const Text(
                        'Iniciar Sesión',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(200),  // Configura el color de fondo del contenedor
                        borderRadius: BorderRadius.circular(10), // Radio de la curva del borde
                        border: Border.all(
                          color: Colors.transparent, // Color del borde
                          width: 0, // Ancho del borde
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpWidget()), // Navega al widget de registro
                          );
                        },
                        child: const Text("No tienes cuenta Regístrate aquí", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ]
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {bool isObscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withAlpha(200),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
class CustomTransitionPage<T> extends Page<T> {
  final Widget child;
  final Widget Function(BuildContext, Animation<double>, Animation<double>, Widget) transitionsBuilder;

  const CustomTransitionPage({
    required this.child,
    required this.transitionsBuilder,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: transitionsBuilder,
    );
  }
}