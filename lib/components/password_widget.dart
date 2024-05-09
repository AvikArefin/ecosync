import 'package:flutter/material.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscure,
      controller: widget._passwordController,
      decoration: InputDecoration(
        filled: true,
        hintText: "Password",
        suffixIcon: IconButton(
          icon: Icon(isObscure
              ? Icons.visibility
              : Icons.visibility_off),
          onPressed: () => setState(
                  () => isObscure = !isObscure,
            ),
        ),
      ),
    );
  }
}