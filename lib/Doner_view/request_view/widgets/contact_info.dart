import 'package:flutter/material.dart';

class ContactInfoWidget extends StatelessWidget {
  final String group;
  
  const ContactInfoWidget({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: CircleAvatar(
        child: Text(
          group,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        radius: 60,
        backgroundColor: Colors.red,
      ),
    );
  }
}
