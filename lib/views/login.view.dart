import 'package:flutter/material.dart';
import 'package:flutter_prueba_ibk/components/custom_elevated_button.component.dart';
import 'package:flutter_prueba_ibk/components/custom_text_field.component.dart';
import 'package:flutter_prueba_ibk/controllers/login.controller.dart';
import 'package:flutter_prueba_ibk/views/products.view.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isSesionActive = false;
  final LoginController controller = Get.put(LoginController());

  final TextEditingController dniController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _loadValidateSesion() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isSesionActive = prefs.getBool('is_sesion_active') ?? false;
    });
    if (_isSesionActive) {
      Get.offAll(() => const ProductsView());
    }
  }

  Future<void> _setSesion() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('is_sesion_active', true);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadValidateSesion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0f172a), // Azul
                    Color(0xFF3b82f6), // Morado
                  ],
                ),
              ),
              child: ListView(
                children: [
                  SizedBox(height: 100),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(39, 255, 255, 255),
                            border: Border.all(
                              color: const Color.fromARGB(60, 255, 255, 255),
                            ),
                          ),
                          padding: EdgeInsetsGeometry.all(14),
                          child: Icon(
                            Icons.account_balance_rounded,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'FINANZAS',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFFDDE0E6),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 40,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Bienvenido',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Montserrat',
                            color: Color(0xFF202B3D),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Ingresa tus datos para continuar',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13,
                            color: Colors.blueGrey[600],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          enabled: true,
                          controller: dniController,
                          label: 'DNI',
                          hint: 'Ingrese su documento de identidad',
                          keyboardType: TextInputType.number,
                          maxLenght: 8,
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          enabled: true,
                          controller: passwordController,
                          label: 'Contraseña',
                          hint: 'Ingrese contraseña',
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          maxLenght: 20,
                        ),
                        SizedBox(height: 20),
                        CustomElevatedButton(
                          label: 'Ingresar',
                          onPressed: () async {
                            String dni = dniController.text;
                            String password = passwordController.text;

                            if (dni.isEmpty ||
                                password.isEmpty ||
                                dni.length < 8 ||
                                password.length < 8) {
                              Get.snackbar(
                                'Error',
                                'Por favor, ingresa Email y Password',
                              );
                            } else {
                              await controller
                                  .login(dni: dni, password: password)
                                  .then((errorMessage) {
                                    if (errorMessage.isNotEmpty) {
                                      Get.snackbar(
                                        'Login fallido',
                                        errorMessage,
                                      );
                                    } else {
                                      _setSesion();
                                      Get.offAll(() => const ProductsView());
                                    }
                                  });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
