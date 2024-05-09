import 'package:ecosync/theme/theme.dart';
import 'package:ecosync/views/land_fill_manager/travel_logs.dart';
import 'package:ecosync/views/sts_manager/sts_dashboard_page.dart';
import 'package:ecosync/views/sts_manager/truck_entry.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import './views/login_page.dart';
import './views/landing_page.dart';
import 'views/land_fill_manager/landfillmanager_dashboard_page.dart';
import 'views/land_fill_manager/truck_entry.dart';
import 'views/sts_manager/fleet_optimization.dart';
import 'views/profile_page.dart';

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(path: '/', builder: (ctx, state) => const LandingPage(), routes: [
    GoRoute(path: 'login', builder: (ctx, state) => const LoginPage()),
    GoRoute(path: 'sts_dashboard', builder: (ctx, state) => const STSDashboardPage(), routes: [
      // Routes for STS Manager
      GoRoute(path: 'profile', builder: (ctx, state) => const ProfilePage(profilePageName: "STS",)),
      GoRoute(path: 'truck_entry', builder: (ctx, state) => const STSTruckEntryPage()),
      GoRoute(path: 'fleet_optimization', builder: (ctx, state) => const STSFleetOptimizationPage()),
    ]),
    GoRoute(path: 'landfillmanager_dashboard', builder: (ctx, state) => const LandFillManagerDashboardPage(), routes: [
      // Routes for STS Manager
      GoRoute(path: 'profile', builder: (ctx, state) => const ProfilePage(profilePageName: "Land Manager Profile")),
      GoRoute(path: 'truck_entry', builder: (ctx, state) => const LandFillManagerTruckEntryPage()),
      GoRoute(path: 'travel_logs', builder: (ctx, state) => const LandFillManagerTravelLogsPage()),
    ]),

  ]),
  // GoRoute(path: '/settings', builder: (ctx, state) => const SettingsPage()),
]);

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      // theme: value ? lightMode : darkMode,
    );
  }
}