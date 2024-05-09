import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/token_controller.dart';

class LandFillManagerDashboardPage extends StatelessWidget {
  const LandFillManagerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LandFillManager Dashboard"),  backgroundColor: Colors.transparent, actions: [IconButton(onPressed: () {
        context.go("/");
        Get.put(TokenController()).setCurrentToken("");
      }, icon: const Icon(Icons.logout))],),
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
            onTap: () => context.go("/landfillmanager_dashboard/travel_logs"),
            child: const ListTile(
              title: Text("Travel Logs"),
              leading: Icon(Icons.file_copy_sharp),
            ),
          ),

        ],
      ),
    );
  }
}
