// app_bar.dart
import 'package:flutter/material.dart';

AppBar customAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: Align(
      alignment: Alignment.topLeft,
      child: RichText(
        text: const TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Red',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 0, 0),
                fontFamily: 'Italiana',
                fontSize: 24,
              ),
            ),
            TextSpan(
              text: 'Drop ',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'Italiana',
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: IconButton(
          icon: const Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
    ],
  );
}
