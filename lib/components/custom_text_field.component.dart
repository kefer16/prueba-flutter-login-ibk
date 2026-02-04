import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool obscureText;
  final bool? enabled;
  final int maxLenght;

  const CustomTextField({
    super.key,
    this.label = "",
    this.hint,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.obscureText = false,
    this.enabled,
    this.maxLenght = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            label,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              color: Colors.blueGrey[500],
              // fontFamily: 'Neuton',
            ),
          ),
        ),
        TextField(
          enabled: enabled,
          keyboardType: keyboardType,
          controller: controller,
          obscureText: obscureText,
          maxLength: maxLenght > 0 ? maxLenght : TextField.noMaxLength,
          decoration: InputDecoration(
            hintText: hint,
            border: UnderlineInputBorder(),
            hintStyle: TextStyle(
              color: Colors.blueGrey[500],
              fontSize: 14,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
