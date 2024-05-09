import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../components/icon_widget.dart';
import '../components/password_widget.dart';
import '../constants/constants.dart';
import '../controllers/token_controller.dart';

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

  void continueSession(BuildContext context) async {
    final token = tokenController.getCurrentToken();
    if (token.isNotEmpty){
      try {
        final profileUrl = Uri.http(baseUrl, "/profile/");
        final profile = await http
            .get(profileUrl, headers: {"Authorization": "Token $token"});
        final int role = jsonDecode(profile.body)["role"] as int;

        // print(token);
        if (!context.mounted) return;
        if (role == 3) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Admin control is not implemented")));
        } else if (role == 4) {
          // Land fill manager
          context.go('/landfillmanager_dashboard');
        } else if (role == 5) {
          context.go('/sts_dashboard');
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
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
          final int role = jsonDecode(profile.body)["role"] as int;


          print(token);
          if (!context.mounted) return;
          if (role == 3) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Admin control is not implemented")));
          }
          else if (role == 4) {
            // Land fill manager
            context.go('/landfillmanager_dashboard');
          } else if (role == 5) {
            context.go('/sts_dashboard');
          }
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
            PasswordWidget(passwordController: _passwordController),
            const SizedBox(height: 10),
            const Spacer(flex: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => continueSession(context),
                  child: const Text('CONTINUE SESSION'),
                ),
                ElevatedButton(
                  onPressed: () => logIn(context),
                  child: const Text('LOG IN'),
                ),
              ],

            ),
            const SizedBox(height: 16,)
          ]),
        )));
  }
}




