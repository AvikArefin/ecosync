import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/truck_entry.dart';

class VehicleList extends StatelessWidget {
  final String vehiclesData;

  const VehicleList({super.key, required this.vehiclesData});

  @override
  Widget build(BuildContext context) {
    var jsonString = jsonDecode(vehiclesData) as List;
    List<Truck> objs = jsonString.map((obj) => Truck.fromJson(obj)).toList();

    return ListView.builder(
      itemCount: objs.length,
      itemBuilder: (context, index) {
        final vehicle = objs[index];
        return ListTile(
          title: Text('ID: ${vehicle.reg}'),
          // subtitle: Text('Vehicle Type: ${vehicle["vehicle_type"]}\n'
              // 'Registration Number: ${vehicle["registration_number"]}\n'
              // 'STS Site: ${vehicle["sts_site"]}'),
        );
      },
    );
  }
}