// ignore: file_names
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Background_Image extends StatelessWidget {
  const Background_Image({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>  const LinearGradient(
        colors: [Colors.white,Colors.white],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
        ).createShader(bounds),
        
      child: Container(
        decoration: const BoxDecoration(image:DecorationImage(image:
        AssetImage('lib/assets/images/background1.png'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.darken)
         ) ),
      ),
    );
  }
}