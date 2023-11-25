import 'package:flutter/material.dart';
import 'package:solar_systems/constants/constants.dart';

class ShowPlanet extends StatelessWidget {

  ShowPlanet({
    required this.ind,
    required this.imageHeight,
    required this.opacity,
    required this.opacityDuration,
    required this.onTap,
    required this.customAnimation,
    super.key});

  final int ind;
  final double imageHeight;
  final double opacity;
  final int opacityDuration;
  final void Function()? onTap;
  final Animation<double> customAnimation;




  final List imagesList  = [kEarthImage,kMars1Image];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: const Duration(seconds: 2),
        transitionBuilder: (Widget child, Animation<double> animation){
          return RotationTransition(
            turns: customAnimation.drive(
              Tween<double>(begin: 0.1,end: -0.5),
            ),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: ind == 0 ? const Offset(0.15, 0.1): const Offset(0.7, 0.4),
                end:  ind == 0 ? const Offset(0-0.6, -0.5) : const Offset(-3.5, -2.2),
              ).animate(customAnimation),
              child: child,
            ),
          );
        },
        child: AnimatedOpacity(
          opacity: opacity,
          duration: Duration(milliseconds: opacityDuration),
          child: SizedBox(
            height: imageHeight,
            child: Image.asset(
                imagesList[ind],
                fit: BoxFit.fill,
            )
          ),
        ),
      ),
    );
  }
}






