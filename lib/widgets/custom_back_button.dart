import 'dart:math';
import 'package:car_maintenance/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi,
      child: Stack(
        children: <Widget>[
          Image.asset(
            "assets/next.png",
            width: 60,
            color: CustomColors.primaryColor,
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.white.withOpacity(0.3),
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
