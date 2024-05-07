import 'dart:convert';

import 'package:ecosync/components/list_item.dart';
import 'package:ecosync/controllers/token_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constants/constants.dart';

class STSTruckEntryPage extends StatefulWidget {
  const STSTruckEntryPage({super.key});

  @override
  State<STSTruckEntryPage> createState() => _STSTruckEntryPageState();
}

class _STSTruckEntryPageState extends State<STSTruckEntryPage> {
  // final textEditingController = TextEditingController();

  // @override
  // void dispose() {
  //   super.dispose();
  //   textEditingController.dispose();
  // }

  String text = "";

  Future<void> getData(BuildContext context, String capacity) async {
    try {
      var url = Uri.http(baseUrl, "mswm/sites/managers/optimized-fleet/", { 'capacity' : "$capacity" });
      final tokenController = Get.put(TokenController());
      final token = tokenController.getCurrentToken();
      final response = await http.get(url, headers: {"Authorization":"Token $token"});
      if (response.statusCode == 200) {
        return showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("Truck"),
            content: VehicleList(vehiclesData: response.body),
            // content: Text(response.body.toString()),
          );
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('A network error occurred')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STS Truck Entry Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            // TextField(controller: textEditingController, keyboardType: TextInputType.number,),
            TextField(onSubmitted: (str) => getData(context, str), keyboardType: TextInputType.number,),
            const SizedBox(height: 16,),

            // ElevatedButton(onPressed: () async {
            //   if (textEditingController.text.isNotEmpty) {
            //     final data = await getData(context, textEditingController.text);
            //     print(data);
            //   }
            // }, child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}
