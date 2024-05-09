import 'dart:convert';
import 'package:ecosync/controllers/token_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constants/constants.dart';

extension DateTimeExtension on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}

class STSTruckEntryPage extends StatefulWidget {
  const STSTruckEntryPage({super.key});

  @override
  State<STSTruckEntryPage> createState() => _STSTruckEntryPageState();
}

class _STSTruckEntryPageState extends State<STSTruckEntryPage> {

  Future<String> getData(BuildContext context) async {
    try {
      var url = Uri.http(baseUrl, "/mswm/travel-logs/");
      final tokenController = Get.put(TokenController());
      final token = tokenController.getCurrentToken();
      final response = await http.get(url, headers: {"Authorization":"Token $token"});
      if (response.statusCode == 201) {
        print(response.body.toString());
        return response.body.toString();
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Land Fill M'),
      ),
      body: Padding(
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
                    Text("Username: ${data["username"]}"),
                    // TODO: Add all the other data points you need
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
    );
  }
}
