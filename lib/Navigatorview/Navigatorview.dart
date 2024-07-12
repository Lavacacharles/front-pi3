import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp3/CallWidget/callwidget.dart';
import 'dart:convert';
import '../ScreenStart/home.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';




class Navigatorview extends StatelessWidget {
  const Navigatorview({super.key});

  void seeMap(BuildContext context) async{
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
  void doCall(BuildContext context) async{
    FlutterPhoneDirectCaller.callNumber("997155313");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('navigation screen'),
            ElevatedButton(
              onPressed: () => seeMap(context),
              child: const Text(
                "Ver mapa",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () => doCall(context),
              child: const Text(
                "Llamada de emergencia",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}