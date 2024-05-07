import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset("assets/logo.png", height: 50), actions: [ElevatedButton(onPressed: () => context.go("/login"), child: const Text("Sign In")), const SizedBox(width: 20,)],),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset('assets/banner.jpg')),
          const Positioned(left: 0, right:0, bottom: 7,child: Text("RUET Unknowns" , textAlign: TextAlign.center,),),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 50),
                Text("Streamlining Waste Management", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
                Text("Efficiently coordinating landfill operations and transfer stations for a cleaner tomorrow.",),
              ],
            ),
          ),
        ],
      ));
  }
}