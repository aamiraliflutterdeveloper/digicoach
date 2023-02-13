class GeneralInfo {
  final String id;
  final String name;
  final String? ceoName;
  final String? surName;
  final String phone;
  final String? description;
  final String? street;
  final String? city;
  final String? country;
  final String? postalCode;
  final String? url;
  final String? email;
  final String? instagram;
  final String? facebook;
  final String? tiktok;
  final String? twitter;
  final bool? active;
  final List<String>? images;

  const GeneralInfo({
     required this.id,
     required this.name,
     this.ceoName,
     this.surName,
     required this.phone,
     this.description,
     this.street,
      this.city,
     this.country,
     this.postalCode,
     this.url,
     this.email,
     this.instagram,
     this.facebook,
     this.tiktok,
     this.twitter,
    this.active = true,
     this.images,
  });

  factory GeneralInfo.fromJson(Map<String, dynamic> json) => GeneralInfo(
        id: json['id'],
        name: json['name'],
        ceoName: json['ceoName'],
        surName: json['surName'],
        phone: json['phone'],
        description: json['description'],
        street: json['street'],
        city: json['city'],
        country: json['country'],
        postalCode: json['postalCode'],
        url: json['url'],
        email: json['email'],
        instagram: json['instagram'],
        facebook: json['facebook'],
        tiktok: json['tiktok'],
        twitter: json['twitter'],
        active: json['active'],
        images: json['images'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'ceoName': ceoName,
        'surName': surName,
        'phone': phone,
        'description': description,
        'street': street,
        'city': city,
        'country': country,
        'postalCode': postalCode,
        'url': url,
        'email': email,
        'instagram': instagram,
        'facebook': facebook,
        'tiktok': tiktok,
        'twitter': twitter,
        'active': active,
        'images': images,
      };
}
