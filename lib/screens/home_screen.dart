import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_systems/constants/constants.dart';

import '../custom_classes/custom_classes.dart';
import '../custom_classes/show_planet.dart';
import '../custom_classes/show_planet_details.dart';
import '../custom_classes/show_planet_name.dart';
import '../models/planet_description_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}






class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{

  late AnimationController _animationController;
  late AnimationController _marsAnimationController;
  late AnimationController _marsHeightAnimationController;

  late Animation<double> _earthOpacityAnimation;
  late Animation<double> _marsOpacityAnimation;
  late Animation<double> _welcomeOpacityAnimation;
  late Animation<double> _earthReverseAnimation;
  late Animation<double> _marsReverseAnimation;
  late Animation<double> _earthAnimation;
  late Animation<double> _marsAnimation;

  double customHeight = 0.0;
  double _marsHeight = 750.0;
  double customWidth = 0.0;
  double backShiningHeight = 400.0;
  double backShiningInitialHeight = 400.0;
  double backShiningFinalHeight = 150.0;

  double marsInitialHeight = 750.0;
  double marsFinalHeight = 300.0;


  double _welcomeOpacity = 1.0;
  double _earthOpacity = 1.0;
  double _marsOpacity = 0.0;

  int index = 0;

  bool showMars = false;
  bool isExpanded = false;
  bool showDetails = false;
  bool showDetailsAnimation = false;


  List<PlanetDescriptionModel> planetValues = [];


  addDetails(){
    planetValues.add(PlanetDescriptionModel(name: 'EARTH', description: 'Our lovely planet'));
    planetValues.add(PlanetDescriptionModel(name: 'MARS', description: 'Neighbor'));
  }

  @override
  void initState() {
    super.initState();
    addDetails();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500)
    );

    _marsAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800)
    );

    _marsHeightAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500)
    );

    _earthOpacityAnimation = Tween<double>(begin: 1.0,end: 0.0).animate(_animationController);
    _welcomeOpacityAnimation = Tween<double>(begin: 1.0,end: 0.0).animate(_marsAnimationController);
    _marsOpacityAnimation = Tween<double>(begin: 0.8,end: 1.0).animate(_marsAnimationController);
    _earthReverseAnimation = Tween<double>(begin: 0.1,end: 0.5).animate(_animationController);

    _marsReverseAnimation = Tween<double>(begin: 0.04,end: 0.1).animate(_marsAnimationController);

    _earthAnimation =  CurvedAnimation(
      curve: Curves.easeOut,
      parent: _earthReverseAnimation,
    );

    _marsAnimation =  CurvedAnimation(
      curve: Curves.easeOut,
      parent: _marsReverseAnimation,
    );


    _animationController.addListener(() {
      setValues();

     if(_animationController.isCompleted){
       setState(() {
         index = index == 1 ? 0:1;
       });
     }
     if(_earthOpacityAnimation.value == 1.0){
       _startMarsAnimation();
     }
    });

    _marsAnimationController.addListener(() {
      setMarsValues();
    });

    _marsHeightAnimationController.addListener(() {
      setState(() {
      _marsHeight = Tween<double>(
          begin: marsInitialHeight,
          end: marsFinalHeight
        ).animate(_marsHeightAnimationController).value;
      });

      backShiningHeight = Tween<double>(
          begin: backShiningInitialHeight,
          end: backShiningFinalHeight
      ).animate(_marsHeightAnimationController).value;

      if(_marsHeightAnimationController.isCompleted){
        setMarsDetailsAnimation();
      }

  });
  }

  setValues() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      _earthOpacity = _earthOpacityAnimation.value;
    });
  }

  setMarsValues() async {
    setState(() {
       showMars = true;
      _marsOpacity = _marsOpacityAnimation.value;
    });
  }

  void startAnimation(){
    _animationController.reset();
    _animationController.forward();
  }

  _startMarsAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    _marsAnimationController.reset();
    _marsAnimationController.forward();
  }

  _startChangeMarsPositionAnimation(){
    setState(() {
      isExpanded = true;
      _marsHeightAnimationController.forward();
      _welcomeOpacity = _welcomeOpacityAnimation.value;

    });
  }

  setMarsDetailsAnimation() async {
    setState(() {
      showDetails = true;
    });
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      showDetailsAnimation = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    customHeight = MediaQuery.of(context).size.height;
    customWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(color: kBGColor),
          setPlanets(),
          Positioned(
            left: customHeight * 0.03,
            top: customHeight * 0.06,
            child: AnimatedOpacity(
              opacity: _welcomeOpacity,
              duration: const Duration(milliseconds: 1500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome',
                      style: GoogleFonts.exo(
                          textStyle: const TextStyle(
                              fontSize: 25,
                              color: kWhiteColor,
                              fontWeight: FontWeight.bold))),
                  const SizedBox(height: 20),
                  Text(
                    'Claire Maiden',
                    style: GoogleFonts.exo(
                        textStyle: const TextStyle(
                            fontSize: 25,
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold)),
                  ),

                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1500),
            top: isExpanded ? 150 : customHeight * 0.38,
            child: BackShining(
              backHeight:backShiningHeight,
            ),
          ),

          Positioned(
            top: customHeight * 0.35,
            left: customWidth * 0.34,
            child: Center(
              child: ShowPlanetName(
                planetName:planetValues[0].name,
                planetDescription:planetValues[0].description,
                opacity:_earthOpacity,
              ),
            ),
          ),

          Positioned(
            top: customHeight * 0.44,
            right: -85,
            child: ShowPlanet(
              ind: 0,
              imageHeight: 600,
              opacity: _earthOpacity,
              opacityDuration: 100,
              customAnimation:_earthAnimation,
              onTap: (){
                startAnimation();
              },
            ),
          ),

          showMars ?  AnimatedPositioned(
            top: isExpanded ? 60 : customHeight * 0.35,
            left: isExpanded ? customWidth * 0.35:customWidth * 0.34,
            duration: const Duration(milliseconds: 1500),
            child: Center(
              child: ShowPlanetName(
                planetName:planetValues[1].name,
                planetDescription:planetValues[1].description,
                opacity:_marsOpacity,
              ),
            ),
          ):const SizedBox(),

         showMars ? AnimatedPositioned(
            top: isExpanded ? 120 : customHeight * 0.38,
            right: isExpanded ? 70 : -140,
            duration: const Duration(milliseconds: 1500),
            child: ShowPlanet(
              ind: 1,
              imageHeight:_marsHeight,
              opacity: _marsOpacity,
              opacityDuration: 800,
              customAnimation:_marsAnimation,
              onTap: (){
                _startChangeMarsPositionAnimation();
              },
            ),
          ):const SizedBox(),



         showDetails ?  AnimatedPositioned(
            top: customHeight * 0.15,
            right: showDetailsAnimation ? customWidth * 0.06 : -customWidth,
            duration: const Duration(milliseconds: 1500),
            child: const Center(
              child: ShowTemprature(),
            ),
          ):const SizedBox(),

          showDetails ? AnimatedPositioned(
            top: customHeight * 0.415,
            right: showDetailsAnimation ? customWidth * 0.25 : -customWidth,
            duration: const Duration(milliseconds: 1500),
            child: const Center(
              child: ShowText(),
            ),
          ):const SizedBox(),

          showDetails ? AnimatedPositioned(
            top: customHeight * 0.48,
            right: showDetailsAnimation ? customWidth * 0 : -customWidth,
            duration: const Duration(milliseconds: 1500),
            child: const Center(
              child: ShowPlanetDetails(),
            ),
          ):const SizedBox(),


        ],
      ),
    );
  }

  Widget setPlanets() {
    return Stack(
      children: [
        Positioned(
            left: customHeight * 0.24,
            top: customHeight * 0.1,
            child: planetsCircle(height: 5.0)),
        Positioned(
            left: customHeight * 0.35,
            top: customHeight * 0.2,
            child: planetsCircle(height: 3.0)),
        Positioned(
            left: customHeight * 0.4,
            top: customHeight * 0.3,
            child: planetsCircle(height: 4.0)),
        Positioned(
            left: customHeight * 0.15,
            top: customHeight * 0.24,
            child: planetsCircle(height: 3.0)),
        Positioned(
            left: customHeight * 0.03,
            top: customHeight * 0.4,
            child: planetsCircle(height: 2.0)),
        Positioned(
            left: customHeight * 0.05,
            top: customHeight * 0.19,
            child: planetsCircle(height: 2.0)),
      ],
    );
  }

  Widget planetsCircle({height}) {
    return CircleAvatar(
      backgroundColor: Colors.white30,
      radius: height,
    );
  }
}
