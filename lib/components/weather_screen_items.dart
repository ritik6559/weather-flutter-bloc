import 'package:flutter/material.dart';

class HourlyForeCastItem extends StatelessWidget {
  final IconData icon;
  final String temperature;
  final String time;

  const HourlyForeCastItem({super.key, 
  
  required this.icon,
   required this.temperature, 
   required this.time});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child:  Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                time,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Icon(
                icon,
                size: 40,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(temperature)
            ],
          ),
        ),
      ),
    );
  }
}
