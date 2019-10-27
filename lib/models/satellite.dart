class Satellite {
  int id;
  String type;
  String name;
  String description;
  DateTime launchDate;
  String codename;

  Satellite(
      {this.id,
      this.type,
      this.name,
      this.description,
      this.launchDate,
      this.codename});

  factory Satellite.fromJson(Map<String, dynamic> json) => Satellite(
        id: json['id'],
        type: json['satellite_type'],
        name: json['name'],
        description: json['description'],
        launchDate: DateTime.parse(json['launch_date']),
        codename: json['codename'],
      );
}
