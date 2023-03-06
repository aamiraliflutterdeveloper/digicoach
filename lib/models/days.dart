enum Days {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  @override
  String toString() =>
      '${name.substring(0, 1).toUpperCase()}${name.substring(1).toLowerCase()}';

  factory Days.fromString(String input) => Days.values.firstWhere(
        (level) => level.name.toLowerCase() == input.toLowerCase(),
        orElse: () => Days.sunday,
      );
}
