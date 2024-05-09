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

class LandFillManagerTravelLogsPage extends StatefulWidget {
  const LandFillManagerTravelLogsPage({super.key});

  @override
  State<LandFillManagerTravelLogsPage> createState() => _LandFillManagerTravelLogsPageState();
}

class _LandFillManagerTravelLogsPageState extends State<LandFillManagerTravelLogsPage> {

  Future<String> getData(BuildContext context) async {
    try {
      var url = Uri.http(baseUrl, "/mswm/travel-logs/");
      final tokenController = Get.put(TokenController());
      final token = tokenController.getCurrentToken();
      final response = await http.get(url, headers: {"Authorization":"Token $token"});
      if (response.statusCode == 200) {
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
        title: const Text('Land Fill Manager: Travel Logs'),
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
                List<dynamic> jsonObs = jsonDecode(snapshot.data!) as List;
                return ListView.builder(
                  itemCount: jsonObs.length,
                  itemBuilder: (context, index) {
                    final vehicle = jsonObs[index];
                    return ListTile(
                      title: SelectableText('ID: ${vehicle['id']}'),
                      subtitle: SelectableText(
                          'Vehicle Type: ${vehicle["site"]}\n'
                              'Registration Number: ${vehicle["arival_time"]}\n'
                              'STS Site: ${vehicle["departure_time"]}\n'
                              'waste_weight: ${vehicle["waste_weight"]}'
                      ),
                    );
                  },
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
