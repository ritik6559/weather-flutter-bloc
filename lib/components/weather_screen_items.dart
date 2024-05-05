import 'package:flutter/material.dart';


class HourlyForeCastItem extends StatelessWidget {
  const HourlyForeCastItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                '3:00',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Icon(
                Icons.cloud,
                size: 40,
              ),
              SizedBox(
                height: 10,
              ),
              Text('300°K')
            ],
          ),
        ),
      ),
    );
  }
}
