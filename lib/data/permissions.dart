import 'package:clients_digcoach/models/club/manager.dart';

/// this is custom list, for permissions ...
/// that we are using in the add managers form ...

 List<Permission> permissions = [
    Permission(id: 0, name: 'Dashboard', read: true, readWrite: true),
    Permission(id: 1, name: 'Clubs', read: true, readWrite: true),
    Permission(id: 2, name: 'Coaches', read: true, readWrite: true),
    Permission(id: 3, name: 'Customers', read: true, readWrite: true),
    Permission(id: 4, name: 'Groups', read: true, readWrite: true),
    Permission(id: 5, name: 'Schedule', read: true, readWrite: true),
    Permission(id: 6, name: 'Lessons', read: true, readWrite: true),
    Permission(id: 7, name: 'Evaluations', read: true, readWrite: true),
    Permission(id: 8, name: 'Messages', read: true, readWrite: true),
    Permission(id: 9, name: 'Other', read: true, readWrite: true),
  ];
