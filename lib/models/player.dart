class Player {
  int id;
  int gameId;
  String nickname;
  List<int> collectedSatellites;

  Player({this.id, this.gameId, this.nickname, this.collectedSatellites});

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json['id'],
        gameId: json['game_id'],
        nickname: json['nickname'],
        collectedSatellites: List<int>.from(json['collected_satellites']),
      );
}
