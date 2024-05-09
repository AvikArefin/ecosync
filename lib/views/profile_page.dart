import 'dart:convert';

import 'package:ecosync/controllers/token_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';



class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.profilePageName});

  final String profilePageName;

  Future<dynamic> getData(BuildContext context) async {
    try {
      var url = Uri.http(baseUrl, "/profile/");
      final tokenController = Get.put(TokenController());
      final token = tokenController.getCurrentToken();
      final response = await http.get(url, headers: {"Authorization":"Token $token"});
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return ('A network error occurred');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(profilePageName),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: FutureBuilder(
            builder: (ctx, snapshot) {
              // Checking if future is resolved or not
              if (snapshot.connectionState == ConnectionState.done) {
                // If we got an error
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );

                  // if we got our data
                } else if (snapshot.hasData) {
                  // Extracting data from snapshot object
                  final data = snapshot.data as dynamic;
                  return Column(
                    children: [
                      Text("id: ${data["id"]}\n"
                          "Username: ${data["username"]}\n"
                          "Name: ${data["name"]}\n"
                          "Email: ${data["email"]}\n"
                          "Role: ${data["role"]}\n"
                          "Managed Site: ${data["managed_site"]}"
                      ),
                    ],
                  );
                }
              }

              // Displaying LoadingSpinner to indicate waiting state
              return const Center(
                child: CircularProgressIndicator(),
              );
            },

            // Future that needs to be resolved
            // inorder to display something on the Canvas
            future: getData(context),
          ),
        ),
      ),
    );
  }
}
