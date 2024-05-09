import 'package:ecosync/controllers/token_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class STSDashboardPage extends StatelessWidget {
  const STSDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("STS Manager Dashboard"),  backgroundColor: Colors.transparent, actions: [IconButton(onPressed: () {
        context.go("/");
        Get.put(TokenController()).setCurrentToken("");
      }, icon: const Icon(Icons.logout))]),
      body: ListView(
        reverse: true,
        children: [
          InkWell(
            onTap: () => context.go("/sts_dashboard/profile"),
            child: const ListTile(
              title: Text("Profile"),
              leading: Icon(Icons.account_box),
            ),
          ),
          InkWell(
            onTap: () => context.go("/sts_dashboard/truck_entry"),
            child: const ListTile(
              title: Text("Add Truck Entry"),
              leading: Icon(Icons.fire_truck),
            ),
          ),
          InkWell(
            onTap: () => context.go("/sts_dashboard/fleet_optimization"),
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
