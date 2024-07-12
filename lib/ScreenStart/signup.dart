import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  bool _isDisabled = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),

        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.8), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            title: const Text("Sign Up"),
            backgroundColor: Colors.transparent, // Transp. porque el fondo es el container
            elevation: 0,
          ),
        ),
      ),

      body: Stack(

        children: [

          Container(

            decoration: const BoxDecoration(

              image: DecorationImage(
                image: AssetImage("assets/image/sigupbackground.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Ajusta el radio aquí
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Ajusta el radio aquí
                      borderSide: const BorderSide(color: Colors.transparent), // Borde cuando está habilitado
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Ajusta el radio aquí
                      borderSide: const BorderSide(color: Colors.blue), // Borde cuando está enfocado
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Ajusta el radio aquí
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Ajusta el radio aquí
                      borderSide: const BorderSide(color: Colors.transparent), // Borde cuando está habilitado
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Ajusta el radio aquí
                      borderSide: const BorderSide(color: Colors.blue), // Borde cuando está enfocado
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Ajusta el radio aquí
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Ajusta el radio aquí
                      borderSide: const BorderSide(color: Colors.transparent), // Borde cuando está habilitado
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Ajusta el radio aquí
                      borderSide: const BorderSide(color: Colors.blue), // Borde cuando está enfocado
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Ajusta el radio aquí
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Ajusta el radio aquí
                      borderSide: const BorderSide(color: Colors.transparent), // Borde cuando está habilitado
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Ajusta el radio aquí
                      borderSide: const BorderSide(color: Colors.blue), // Borde cuando está enfocado
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Disabled'),
                  value: _isDisabled,
                  onChanged: (bool value) {
                    setState(() {
                      _isDisabled = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _signUp,
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _signUp() {
    // Implement your sign-up logic here
    print('Signing up with:');
    print('Username: ${_usernameController.text}');
    print('Password: ${_passwordController.text}');
    print('Email: ${_emailController.text}');
    print('Full Name: ${_fullNameController.text}');
    print('Disabled: $_isDisabled');
  }
}

