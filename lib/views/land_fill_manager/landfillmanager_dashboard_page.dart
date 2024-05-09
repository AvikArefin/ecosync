import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandFillManagerDashboardPage extends StatelessWidget {
  const LandFillManagerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LandManager Dashboard"),  backgroundColor: Colors.transparent),
      body: ListView(
        reverse: true,
        children: [
          InkWell(
            onTap: () => context.go("/landfillmanager_dashboard/profile"),
            child: const ListTile(
              title: Text("Profile"),
              leading: Icon(Icons.account_box),
            ),
          ),
          InkWell(
            onTap: () => context.go("/landfillmanager_dashboard/truck_entry"),
            child: const ListTile(
              title: Text("Add Truck Entry"),
              leading: Icon(Icons.fire_truck),
            ),
          ),
          InkWell(
            // onTap: () => context.go("/dashboard/landmanager_fleet_optimization"),
            child: const ListTile(
              title: Text("Fleet Optimization"),
              leading: Icon(Icons.stacked_line_chart_rounded),
            ),
          ),

        ],
      ),
    );
  }
}
