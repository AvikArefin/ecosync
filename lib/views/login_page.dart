import 'dart:convert';

import 'package:ecosync/constants/constants.dart';
import 'package:ecosync/controllers/token_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final tokenController = Get.put(TokenController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void logIn(BuildContext context) async {
    if (_nameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      try {
        var url = Uri.http(baseUrl, "/auth/login/");
        var response = await http.post(url, body: {
          "username": _nameController.text,
          "password": _passwordController.text
        });
        if (response.statusCode == 200) {
          final token = jsonDecode(response.body)["key"];
          tokenController.setCurrentToken(token);

          final profileUrl = Uri.http(baseUrl, "/profile/");
          final profile = await http.get(profileUrl, headers: {"Authorization":"Token $token"});
          final int role = jsonDecode(profile.body)["role"];


          print(token);
          if (!context.mounted) return;
          context.go('/dashboard');
        } else {
          print('A network error occurred');
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const IconWidget(),
            const Spacer(flex: 1),
            const Text('Welcome back!'),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                filled: true,
                hintText: "User",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                filled: true,
                hintText: "Password",
              ),
            ),
            const SizedBox(height: 10),
            const Spacer(flex: 1),
            ElevatedButton(
              onPressed: () => logIn(context),
              child: const Text('LOG IN'),
            ),
            const Spacer(flex: 1),
          ]),
        )));
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/icon.png", height: 60, width: 60),
        const SizedBox(width: 5),
        const SizedBox(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("EcoSync",
                  style: TextStyle(
                      fontSize: 50, fontWeight: FontWeight.bold, height: 0.8)),
              Text('Streamlining Waste Management',
                  style: TextStyle(height: 0.9)),
            ],
          ),
        ),
      ],
    );
  }
}
