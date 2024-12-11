// contact_info.dart
import 'package:flutter/material.dart';

class ContactInfo extends StatelessWidget {
  final String title;
  final String value;

  const ContactInfo({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          '$title : $value',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
