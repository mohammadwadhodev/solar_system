import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_systems/constants/constants.dart';

class ShowPlanetName extends StatelessWidget {
   const ShowPlanetName({

    required this.planetName,
    required this.planetDescription,
    required this.opacity,
    super.key});

  final String planetName;
  final String planetDescription;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Column(

    children: [
      AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(seconds: 1),
        child: Text(planetName,
        style:GoogleFonts.exo(
          textStyle: const TextStyle(
            color: kWhiteColor,
            fontSize: 45,
            fontWeight: FontWeight.bold,
          )
        )
        ),
      ),
      AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(seconds: 1),
        child: Text(planetDescription,
            style:GoogleFonts.exo(
                textStyle: const TextStyle(
                  color: kWhiteColor,
                  fontSize: 20,
                )
            )
        ),
      ),
    ],
    );
  }
}
