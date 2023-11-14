import 'package:flutter/material.dart';

class EasyDataTableEmptyWidget extends StatelessWidget {
  const EasyDataTableEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            size: 20.0,
            color: Colors.blue,
          ),
          SizedBox(width: 8.0),
          Text(
            'No data available',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
