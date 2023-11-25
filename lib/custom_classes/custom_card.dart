import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_systems/constants/constants.dart';

class CustomCard extends StatelessWidget {

  final Widget leading;
  final String title;
  final String subtitle;


  const CustomCard({
    required this.leading,
    required this.title,
    required this.subtitle,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: kCardBGSecondaryColor,
        borderRadius: BorderRadius.circular(50)
      ),
      child: Center(
        child: ListTile(
          leading:LeadingWidget(leading:leading),
          title: Text(title,style: GoogleFonts.exo2(
            textStyle: TextStyle(fontSize: 21,color: Colors.white.withOpacity(0.8))
          ),),
          subtitle:Container(
            padding: const EdgeInsets.only(top: 10),
            child : Text(subtitle,style: GoogleFonts.exo2(
                textStyle: const TextStyle(fontSize: 22,color: Colors.white)
            ),),
          ) ,
        ),
      ),
    );
  }
}


class LeadingWidget extends StatelessWidget {

  final Widget leading;

  const LeadingWidget({
    required this.leading,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [

            BoxShadow(
              color: Colors.blue.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 20,
              offset: const Offset(0, 1)
            )

          ]

        ),
        child: leading,
      ),
    );
  }
}

