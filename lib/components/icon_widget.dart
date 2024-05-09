import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/icon.png", height: 60, width: 60),
        const SizedBox(width: 5),
        const SizedBox(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("EcoSync",
                  style: TextStyle(
                      fontSize: 50, fontWeight: FontWeight.bold, height: 0.8)),
              Text('Streamlining Waste Management',
                  style: TextStyle(height: 0.9)),
            ],
          ),
        ),
      ],
    );
  }
}