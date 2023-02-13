// A model class for tennis coach

class Coach {
  final String id;
  final List<String> clubsId;
  final String name;
  final String surName;
  final String phone;
  final String? secondSurName;
  final String? street;
  final String? city;
  final String? country;
  final String? postalCode;
  final String? image;
  final String? description;
  final String? birthDate;
  final bool active;
  final bool isMale;

  const Coach({
    required this.id,
    required this.clubsId,
    required this.name,
    required this.surName,
    required this.phone,
    this.image,
    this.description,
    this.secondSurName,
    this.birthDate,
    required this.active,
    this.isMale = true,
    this.street,
    this.city,
    this.country,
    this.postalCode,
  });

  factory Coach.fromJson(Map<String, dynamic> json) => Coach(
        id: json['id'],
        clubsId: json['clubId'] != null
            ? (json['clubId'] as List<String>).map((e) => e).toList()
            : [],
        name: json['name'],
        street: json['street'],
        city: json['city'],
        country: json['country'],
        postalCode: json['postalCode'],
        phone: json['phone'],
        image: json['image'],
        description: json['description'],
        surName: json['surName'],
        secondSurName: json['secondSurName'],
        birthDate: json['birthDate'],
        active: json['active'],
        isMale: json['gender'],
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
        'image': image,
        'description': description,
        'surName': surName,
        'secondSurName': secondSurName,
        'birthDate': birthDate,
        'active': active,
        'gender': isMale,
      };
}
