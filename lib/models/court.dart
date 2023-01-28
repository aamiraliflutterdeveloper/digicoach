// A model class for tennis court
class Court {
  final String id;
  final String clubId;
  final String name;
  final String address;
  final String image;
  final String description;

  Court(
      {required this.id,
      required this.clubId,
      required this.name,
      required this.address,
      required this.image,
      required this.description});

  factory Court.fromJson(Map<String, dynamic> json) {
    return Court(
      id: json['id'],
      clubId: json['clubId'],
      name: json['name'],
      address: json['address'],
      image: json['image'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clubId': clubId,
      'name': name,
      'address': address,
      'image': image,
      'description': description,
    };
  }
}
