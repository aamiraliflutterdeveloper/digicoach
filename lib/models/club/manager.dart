import 'dart:typed_data';

class Manager {
  final String id;
  final String name;
  final String surname;
  final String? secondSurname;
  final String phone;
  final String email;
  final List<Uint8List>? photoUrlInBytes;
  final List<String>? photoUrl;
  final bool manageAllClubs;
  // final List<bool> readPermissions;
  final List<Permission> permission;
  // final List<bool> readWritePermissions;

  const Manager({
    required this.id,
    required this.name,
    required this.surname,
    this.secondSurname,
    required this.phone,
    required this.email,
    this.photoUrl = const [],
    this.photoUrlInBytes = const [],
    this.manageAllClubs = true,
    this.permission =  const [],
  });

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        id: json['id'],
        name: json['name'],
        surname: json['surname'],
        secondSurname: json['secondSurname'],
        phone: json['phone'],
        email: json['email'],
        photoUrl: (json["photoUrl"] as List).map((e) => e as String).toList(),
        manageAllClubs: json['manageAllClubs'],
        permission: List<Permission>.from(json["permission"].map((x) => Permission.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'surname': surname,
        'secondSurname': secondSurname,
        'phone': phone,
        'email': email,
        'photoUrl': photoUrl,
        'manageAllClubs': manageAllClubs,
        'permission': List<dynamic>.from(permission.map((x) => x.toJson())),
      };

  Manager copyWith({
    final String? id,
    final String? name,
    final String? surname,
    final String? secondSurname,
    final String? phone,
    final String? email,
    final List<String>? photoUrl,
    final bool? manageAllClubs,
    final List<bool>? readPermissions,
    final List<bool>? readWritePermissions,
    final List<Permission>? permission,
  }) =>
      Manager(
        id: id ?? this.id,
        name: name ?? this.name,
        surname: surname ?? this.surname,
          secondSurname: secondSurname ?? this.secondSurname,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        photoUrl: photoUrl ?? this.photoUrl,
        manageAllClubs: manageAllClubs ?? this.manageAllClubs,
        permission: List.from(this.permission)
      );

}


/// this is permissions class ...
// Little bit i have changed the way, due to additions of permissions in the form ...

class Permission {
  const Permission({
    required this.id,
    this.name = '',
    this.read = true,
    this.readWrite = true,
  });

  final int id;
  final String name;
  final bool read;
  final bool readWrite;

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
    id: json["id"],
    name: json["name"],
    read: json["read"],
    readWrite: json["readWrite"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "read": read,
    "readWrite": readWrite,
  };

  Permission copyWith({int? id, String? name, bool? read, bool? readWrite }) {
    return Permission(
      id: id ?? this.id,
      name: name ?? this.name,
      read: read ?? this.read,
      readWrite: readWrite ?? this.readWrite
    );
  }


}


