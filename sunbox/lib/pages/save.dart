class Save{
  String title;
  int latitude;
  int longitude ;

  Save({
    required this.title,
    required this.latitude,
    required this.longitude,
  });

  Save.fromMap(Map map):
    this.title = map['title'],
    this.latitude = map['latitude'],
    this.longitude = map['longitude'];


  Map toMap(){
    return {
      'title': this.title,
    };
  }
}