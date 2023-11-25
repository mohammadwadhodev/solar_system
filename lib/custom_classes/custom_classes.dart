import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_systems/constants/constants.dart';

class BackShining extends StatelessWidget {

  final double backHeight;

   const BackShining({
    required this.backHeight,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: backHeight,
      width: MediaQuery.of(context).size.width * 0.99,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0xff1d3c7d),
            spreadRadius: 0,
            blurRadius: 130,
            offset: Offset(0, 3),
          ),
          BoxShadow(
            color: Color(0xff1d3c7d),
            spreadRadius: 0,
            blurRadius:130,
            offset: Offset(0, 3),
          ),
          BoxShadow(
            color: Color(0xff1d3c7d),
            spreadRadius: 0,
            blurRadius:130,
            offset: Offset(0, 3),
          ),
        ]
      ),
    );
  }
}



class ShowTemprature extends StatelessWidget {
  const ShowTemprature({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.115,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        shape: BoxShape.circle
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(kTemperatureIcon,color: kWhiteColor),
          ),
          const Text('-75',style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),)
        ],
      ),
    );
  }
}

class ShowText extends StatelessWidget {
  const ShowText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('DUNYADAN UZAKLIK',
        style: GoogleFonts.exo(
          textStyle: TextStyle(fontSize: 21,color: Colors.white.withOpacity(0.8))
        ),
        ),

        Text('1 ISIK YILI',
          style: GoogleFonts.exo(
              textStyle: const TextStyle(fontSize: 22,color: Colors.white))
          ),
      ],
    );
  }
}


