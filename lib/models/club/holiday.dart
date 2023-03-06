class Holiday {
  final DateTime from;
  final DateTime to;

  const Holiday({
    required this.from,
    required this.to,
  });

  factory Holiday.standard({
    DateTime? from,
    Duration fromAdd = const Duration(days: 24),
    Duration toAdd = const Duration(days: 7),
  }) {
    final oldFrom = from ?? DateTime.now();

    final newFrom = oldFrom.add(fromAdd).copyWith(hour: 0, minute: 0);
    final newTo = newFrom.add(toAdd).copyWith(hour: 23, minute: 59);

    return Holiday(from: newFrom, to: newTo);
  }

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
        from: json['from'],
        to: json['to'],
      );
  Map<String, dynamic> toJson() => {
        'from': from,
        'to': to,
      };
}
