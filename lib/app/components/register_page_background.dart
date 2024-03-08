import 'package:flutter/material.dart';

class RegisterPageBackground extends StatelessWidget {
  const RegisterPageBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          Colors.black,
          Colors.black12,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment(0, -0.2),
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imgs/RegisterBackground.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
      ),
    );
  }
}
