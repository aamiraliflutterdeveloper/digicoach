// A model class for tennis court
class Court {
  final String id;
  final String clubId;
  final String name;
  final String address;
  final String image;
  final String description;
  final int courtNumber;

  const Court({
    required this.id,
    required this.clubId,
    required this.name,
    required this.address,
    required this.image,
    required this.description,
    required this.courtNumber,
  });

  factory Court.fromJson(Map<String, dynamic> json) => Court(
        id: json['id'],
        clubId: json['clubId'],
        name: json['name'],
        address: json['address'],
        image: json['image'],
        description: json['description'],
        courtNumber: json['courtNumber'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'clubId': clubId,
        'name': name,
        'address': address,
        'image': image,
        'description': description,
        'courtNumber': courtNumber,
      };
}
