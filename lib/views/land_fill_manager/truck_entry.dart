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
  State<LandFillManagerTruckEntryPage> createState() =>
      _LandFillManagerTruckEntryPageState();
}

class _LandFillManagerTruckEntryPageState
    extends State<LandFillManagerTruckEntryPage> {
  int? selectedTruck;
  String wasteWeight = "";
  TimeOfDay? arrivalTime = TimeOfDay.now();
  TimeOfDay? departureTime = TimeOfDay.now();

  Future<void> sendData(BuildContext context) async {
    try {
      var url = Uri.http(baseUrl, "/mswm/travel-logs/");
      final tokenController = Get.put(TokenController());
      final token = tokenController.getCurrentToken();
      final response = await http.post(url, headers: {
        "Authorization": "Token $token"
      }, body:

          {
        "vehicle": selectedTruck.toString(),
        "waste_weight": wasteWeight.toString(),
        "arrival_time":
            "${DateTime.now().applied(arrivalTime!).toIso8601String().split(".")[0]}.709Z",
        "departure_time":
            "${DateTime.now().applied(departureTime!).toIso8601String().split(".")[0]}.709Z",
        "site": "3"
      });
      print(response.body);
      if (response.statusCode == 201) {
        print(response.body.toString());
        return showDialog(
            context: context,
            builder: (context) {
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
        title: const Text('LandFillManager: Truck Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const Text("Selected Truck No"),
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
            const SizedBox(
              height: 16,
            ),
            TextField(
              onChanged: (value) => wasteWeight = value.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                hintText: "Weight of Waste",
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    arrivalTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {});
                  },
                  icon: const Icon(Icons.timelapse),
                  label: Text("START: ${arrivalTime!.hour} ${arrivalTime!.minute}"),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    departureTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {});
                  },
                  icon: const Icon(Icons.timelapse),
                  label: Text("END: ${departureTime!.hour} ${departureTime!.minute}"),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: () async {
                  await sendData(context);
                },
                child: const Text("Submit")),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
