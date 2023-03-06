class Manager {
  final String id;
  final String name;
  final String surname;
  final String phone;
  final String email;
  final String photoUrl;
  final bool manageAllClubs;
  final List<bool> readPermissions;
  final List<bool> readWritePermissions;

  const Manager({
    required this.id,
    required this.name,
    required this.surname,
    required this.phone,
    required this.email,
    this.photoUrl = '',
    this.manageAllClubs = true,
    this.readPermissions = const [true],
    this.readWritePermissions = const [true],
  });

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        id: json['id'],
        name: json['name'],
        surname: json['surname'],
        phone: json['phone'],
        email: json['email'],
        photoUrl: json['photoUrl'],
        manageAllClubs: json['manageAllClubs'],
        readPermissions: json['readPermissions'],
        readWritePermissions: json['readWritePermissions'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'surname': surname,
        'phone': phone,
        'email': email,
        'photoUrl': photoUrl,
        'manageAllClubs': manageAllClubs,
        'readPermissions': readPermissions,
        'readWritePermissions': readWritePermissions,
      };

  Manager copyWith({
    final String? id,
    final String? name,
    final String? surname,
    final String? phone,
    final String? email,
    final String? photoUrl,
    final bool? manageAllClubs,
    final List<bool>? readPermissions,
    final List<bool>? readWritePermissions,
  }) =>
      Manager(
        id: id ?? this.id,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        manageAllClubs: manageAllClubs ?? this.manageAllClubs,
        readPermissions: readPermissions ?? this.readPermissions,
        readWritePermissions: readWritePermissions ?? this.readWritePermissions,
      );
}
