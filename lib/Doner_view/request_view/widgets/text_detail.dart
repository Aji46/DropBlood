import 'package:flutter/material.dart';

class DetailText extends StatelessWidget {
  final String title;
  final String? value;

  const DetailText({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11),
      child: Text(
        '$title: ${value ?? ''}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
    );
  }
}
