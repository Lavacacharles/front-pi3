import 'package:flutter/material.dart';
import '../views/maps_view.dart';


class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Map view"),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                // Implementar la lógica de cierre de sesión
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: const MapView(),


      ),
    );
  }
}
