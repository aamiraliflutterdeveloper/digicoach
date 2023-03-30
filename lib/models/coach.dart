import 'dart:typed_data';

class Coach {
  final String id;
  final List<String> clubsId;
  final String name;
  final String surname;
  final String phone;
  final String? secondSurName;
  final String? street;
  final String? city;
  final String? country;
  final String? postalCode;
  final List<Uint8List>? photoUrlInBytes;
  final List<String>? photoUrl;
  final String? description;
  final String birthDate;
  final bool active;
  final bool isMale;
  final int coachingLevel;

  const Coach({
    required this.id,
     this.clubsId = const [],
    required this.name,
    required this.surname,
    required this.phone,
    this.description,
    this.secondSurName,
    required this.birthDate,
    required this.active,
    this.isMale = true,
    this.street,
    this.city,
    this.country,
    this.postalCode,
    required this.coachingLevel,
    this.photoUrl = const [],
    this.photoUrlInBytes = const [],
  });

  factory Coach.fromJson(Map<String, dynamic> json) => Coach(
        id: json['id'] ?? '',
        clubsId: json['clubId'] != null ? (json['clubId'] as List).map((e) => e as String).toList() : [],
        name: json['name'] ?? '',
        street: json['street'] ?? '',
        city: json['city'] ?? '',
        country: json['country'] ?? '',
        postalCode: json['postalCode'] ?? '',
        phone: json['phone'] ?? '',
        description: json['description'] ?? '',
        surname: json['surName'] ?? '',
        secondSurName: json['secondSurName'] ?? '',
        birthDate: json['birthDate'] ?? '',
        active: json['active'] ?? '',
        isMale: json['gender'] ?? '',
        coachingLevel: json['coachingLevel'] ?? '',
        photoUrl: (json["photoUrl"] as List).map((e) => e as String).toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'clubId': clubsId.map((e) => e).toList(),
        'name': name,
        'street': street,
        'city': city,
        'country': country,
        'postalCode': postalCode,
        'phone': phone,
        'description': description,
        'surName': surname,
        'secondSurName': secondSurName,
        'birthDate': birthDate,
        'active': active,
        'gender': isMale,
        'coachingLevel': coachingLevel,
        'photoUrl': photoUrl,

      };


  /// copy with constructor
  Coach copyWith({
    final String? id,
    final List<String>? clubsId,
    final String? name,
    final String? surname,
    final String? phone,
    final String? secondSurName,
    final String? street,
    final String? city,
    final String? country,
    final String? postalCode,
    final List<String>? photoUrl,
    final String? description,
    final String? birthDate,
    final bool? active,
    final bool? isMale,
    final int? coachingLevel,
  }) =>
      Coach(
          id: id ?? this.id,
        clubsId: List.from(this.clubsId),
         name: name ?? this.name,
          surname: surname ?? this.surname,
          secondSurName: secondSurName ?? this.secondSurName,
          phone: phone ?? this.phone,
          street: street ?? this.street,
          city: city ?? this.city,
          country: country ?? this.country,
          postalCode: postalCode ?? this.postalCode,
          photoUrl: photoUrl ?? this.photoUrl,
          description: description ?? this.description,
          birthDate: birthDate ?? this.birthDate,
          active: active ?? this.active,
          isMale: isMale ?? this.isMale,
          coachingLevel: coachingLevel ?? this.coachingLevel,


      );







}
