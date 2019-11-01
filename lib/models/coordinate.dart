class Coordinate {
  String id;
  double azimuth;
  double elevation;

  Coordinate({this.id, this.azimuth, this.elevation});

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
    azimuth: json['coordinates']['azi'],
    elevation: json['coordinates']['alt'],
    id: json['id'],
  );
}