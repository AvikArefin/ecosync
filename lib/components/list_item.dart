import 'dart:convert';

import 'package:flutter/material.dart';

class VehicleList extends StatelessWidget {
  final String data;

  const VehicleList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<dynamic> jsonObjects = jsonDecode(data) as List;

    // // Printing each JSON object
    // for (var jsonObj in jsonObjects) {
    //   print(jsonObj['registration_number']);
    // }

    return ListView.builder(
      itemCount: jsonObjects.length,
      itemBuilder: (context, index) {
        final vehicle = jsonObjects[index];
        return ListTile(
          title: Text('ID: ${vehicle['id']}'),
          // subtitle: Text('Vehicle Type: ${vehicle["vehicle_type"]}\n'
              // 'Registration Number: ${vehicle["registration_number"]}\n'
              // 'STS Site: ${vehicle["sts_site"]}'),
        );
      },
    );
  }
}