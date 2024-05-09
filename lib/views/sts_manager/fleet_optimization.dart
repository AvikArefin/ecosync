import 'dart:convert';

import 'package:ecosync/controllers/token_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constants/constants.dart';

class STSFleetOptimizationPage extends StatelessWidget {
  const STSFleetOptimizationPage({super.key});

  Future<void> getData(BuildContext context, String capacity) async {
    try {
      var url = Uri.http(baseUrl, "/mswm/sites/managers/optimized-fleet/",
          {'capacity': capacity});
      final tokenController = Get.put(TokenController());
      final token = tokenController.getCurrentToken();
      final response =
          await http.get(url, headers: {"Authorization": "Token $token"});
      if (response.statusCode == 200) {
        List<dynamic> jsonObjs = jsonDecode(response.body) as List;
        double containerHeight =
            jsonObjs.length * 100.0 > 400 ? 400 : jsonObjs.length * 100;
        return showDialog(
            builder: (context) {
              return AlertDialog(
                title: const Text("Truck"),
                content: SizedBox(
                  height: containerHeight, // Change as per your requirement
                  width: 300.0,
                  child: ListView.builder(
                    itemCount: jsonObjs.length,
                    itemBuilder: (context, index) {
                      final vehicle = jsonObjs[index];
                      return ListTile(
                        title: SelectableText('ID: ${vehicle['id']}'),
                        subtitle: SelectableText(
                            'Vehicle Type: ${vehicle["vehicle_type"]}\n'
                            'Registration Number: ${vehicle["registration_number"]}\n'
                            'STS Site: ${vehicle["sts_site"]}'),
                      );
                    },
                  ),
                ),
              );
            },
            context: context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('A network error occurred')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STS Fleet Optimization Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const Text("Waste Volume"),
            TextField(
              onSubmitted: (str) => getData(context, str),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
