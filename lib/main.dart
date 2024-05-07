import 'package:ecosync/theme/theme.dart';
import 'package:ecosync/views/dashboard_page.dart';
import 'package:ecosync/views/sts_manager/truck_entry.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import './views/login_page.dart';
import './views/landing_page.dart';
import 'views/sts_manager/fleet_optimization.dart';
import 'views/sts_manager/profile_page.dart';

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(path: '/', builder: (ctx, state) => const LandingPage(), routes: [
    GoRoute(path: 'login', builder: (ctx, state) => const LoginPage()),
    GoRoute(path: 'dashboard', builder: (ctx, state) => const DashboardPage(), routes: [
      // Routes for STS Manager
      GoRoute(path: 'sts_profile', builder: (ctx, state) => const STSProfilePage()),
      GoRoute(path: 'sts_truck_entry', builder: (ctx, state) => const STSTruckEntryPage()),
      GoRoute(path: 'sts_fleet_optimization', builder: (ctx, state) => const STSFleetOptimizationPage()),
    ]),
    
    // GoRoute(path: 'rooms', builder: (ctx, state) => RoomsPage(), routes: [
      // GoRoute(
      //   path: 'chat',
      //   builder: (ctx, state) {
      //     return ChatPage(room: state.extra as Room);
      //   },
      // ),
      // GoRoute(path: 'room_builder', builder: (ctx, state) {
      //   return const RoomCreatorPage();
      // }),
    // ]),
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