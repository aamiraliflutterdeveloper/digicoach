enum DaysWeek {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday;

  @override
  String toString() =>
      '${name.substring(0, 1).toUpperCase()}${name.substring(1).toLowerCase()}';

  factory DaysWeek.fromString(String input) => DaysWeek.values.firstWhere(
        (level) => level.name.toLowerCase() == input.toLowerCase(),
    orElse: () => DaysWeek.sunday,
  );
}
