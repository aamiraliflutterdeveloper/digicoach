// A model class for tennis coach

class Coach {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String image;
  final String description;

  Coach({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.image,
    required this.description,
  });

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      image: json['image'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'image': image,
      'description': description,
    };
  }
}
