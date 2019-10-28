class Player {
  int id;
  int gameId;
  String nickname;
  List<String> availableSatellites;
  List<String> collectedSatellites;

  Player(
      {this.id,
      this.gameId,
      this.nickname,
      this.collectedSatellites,
      this.availableSatellites});

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json['id'],
        gameId: json['game_id'],
        nickname: json['nickname'],
        collectedSatellites: List<String>.from(json['collected_satellites']),
        availableSatellites: List<String>.from(json['game']['satellites']),
      );
}
