class PlanetDescriptionModel{
  String name;
  String description;


  PlanetDescriptionModel({
    required this.name,
    required this.description,
});


  Map<String,dynamic> toJSON(){
    return {
      'name':name,
      'description':description,
    };
  }

}