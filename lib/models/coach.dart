// A model class for tennis coach

class Coach {
  final String id;
  final String clubId;
  final String name;
  final String address;
  final String phone;
  final String image;
  final String description;

  const Coach({
    required this.id,
    required this.clubId,
    required this.name,
    required this.address,
    required this.phone,
    required this.image,
    required this.description,
  });

  factory Coach.fromJson(Map<String, dynamic> json) => Coach(
        id: json['id'],
        clubId: json['clubId'],
        name: json['name'],
        address: json['address'],
        phone: json['phone'],
        image: json['image'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'clubId': clubId,
        'name': name,
        'address': address,
        'phone': phone,
        'image': image,
        'description': description,
      };
}
