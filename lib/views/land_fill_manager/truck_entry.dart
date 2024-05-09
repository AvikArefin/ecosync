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

class LandFillManagerTruckEntryPage extends StatefulWidget {
  const LandFillManagerTruckEntryPage({super.key});

  @override
  State<LandFillManagerTruckEntryPage> createState() => _LandFillManagerTruckEntryPageState();
}

class _LandFillManagerTruckEntryPageState extends State<LandFillManagerTruckEntryPage> {
  int? selectedTruck;
  String wasteWeight = "";
  TimeOfDay? startTime = TimeOfDay.now();
  TimeOfDay? endTime = TimeOfDay.now();

  Future<void> sendData(BuildContext context) async {
    try {
      var url = Uri.http(baseUrl, "/mswm/travel-logs/");
      final tokenController = Get.put(TokenController());
      final token = tokenController.getCurrentToken();
      final response = await http.post(url, headers: {"Authorization":"Token $token"}, body: {
        "site": "0",
        "vehicle": selectedTruck.toString(),
        "arrival_time": DateTime.now().applied(startTime!).toIso8601String(),
        "departure_time": DateTime.now().applied(endTime!).toIso8601String(),
        "waste_weight": wasteWeight.toString()
      });
      if (response.statusCode == 201) {
        print(response.body.toString());
        return showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: const Text("Upload"),
            content: Text(response.body.toString()),
          );
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
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
            Text("Selected Truck No"),
          Wrap(
          spacing: 8.0,
          children: <Widget>[
            ChoiceChip(
              label: const Text('1'),
              selected: selectedTruck == 1,
              onSelected: (bool selected) {
                setState(() {
                  selectedTruck = 1;
                });
              },
            ),
            ChoiceChip(
              label: const Text('2'),
              selected: selectedTruck == 2,
              onSelected: (bool selected) {
                setState(() {
                  selectedTruck = 2;
                });
              },
            ),
            ChoiceChip(
              label: const Text('3'),
              selected: selectedTruck == 3,
              onSelected: (bool selected) {
                setState(() {
                  selectedTruck == 3;
                });
              },
            ),
          ],
        ),
            SizedBox(height: 16,),
            Text("Weight of Waste"),
            TextField(onChanged: (value) => wasteWeight = value.toString(), keyboardType: TextInputType.number,),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(onPressed: () async {
                  startTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  setState(() {});
                }, icon: const Icon(Icons.timelapse), label: Text("START: ${startTime!.hour} ${startTime!.minute}"),),
                ElevatedButton.icon(onPressed: () async {
                  endTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  setState(() {});
                }, icon: const Icon(Icons.timelapse), label: Text("END: ${endTime!.hour} ${endTime!.minute}"),),
              ],
            ),
            SizedBox(height: 16,),


            ElevatedButton(onPressed: () async {
                await sendData(context);
            }, child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}
