// A model class for tennis court
class Court {
  final String id;
  final String clubId;
  final String name;
  final String description;
  final int courtNumber;
  final int sport;
  final int type;
  final int closure;
  final int numberPlayers;
  final bool active;
  final bool outsideCourtEnable;

  const Court({
    required this.id,
    required this.clubId,
    required this.name,
    required this.description,
    required this.courtNumber,
    this.sport = 0,
    this.type = 0,
    this.closure = 0,
    this.numberPlayers = 0,
    this.active = true,
    this.outsideCourtEnable = false,
  });

  factory Court.fromJson(Map<String, dynamic> json) => Court(
        id: json['id'],
        clubId: json['clubId'],
        name: json['name'],
        description: json['description'],
        courtNumber: json['courtNumber'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'clubId': clubId,
        'name': name,
        'description': description,
        'courtNumber': courtNumber,
      };
}
