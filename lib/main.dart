import 'package:flutter/material.dart';
import 'package:flutter_prueba_ibk/views/login.view.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          primary: Colors.blueGrey[200],
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),

      home: LoginView(),
    );
  }
}
