import 'package:flutter/material.dart';

class AdditonalInfpItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const AdditonalInfpItem({
    super.key,
    required this.icon, 
    required this.label,
    required this.value
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: Column(
        children: [
          Icon(
            icon,
            size: 50,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          )
        ],
      ),
    );
  }
}
