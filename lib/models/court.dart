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

  Court copy({
    final String? id,
    final String? clubId,
    final String? name,
    final String? description,
    final int? courtNumber,
    final int? sport,
    final int? type,
    final int? closure,
    final int? numberPlayers,
    final bool? active,
    final bool? outsideCourtEnable,
  }) =>
      Court(
        id: id ?? this.id,
        clubId: clubId ?? this.clubId,
        name: name ?? this.name,
        description: description ?? this.description,
        courtNumber: courtNumber ?? this.courtNumber,
        sport: sport ?? this.sport,
        type: type ?? this.type,
        closure: closure ?? this.closure,
        numberPlayers: numberPlayers ?? this.numberPlayers,
        active: active ?? this.active,
        outsideCourtEnable: outsideCourtEnable ?? this.outsideCourtEnable,
      );
}
