import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final Icon? prefixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController controller;

  CustomTextField({
    required this.labelText,
    this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword && _obscure,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: !widget.isPassword
            ? null
            : IconButton(
                icon: _obscure
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
              ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 23, 23, 24),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: const Color.fromARGB(206, 56, 182, 236),
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
