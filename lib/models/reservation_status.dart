enum ReservationStatus {
  pending,
  confirmed,
  cancelled,
  completed;

  @override
  String toString() =>
      '${name.substring(0, 1).toUpperCase()}${name.substring(1).toLowerCase()}';

  factory ReservationStatus.fromString(String input) =>
      ReservationStatus.values.firstWhere(
        (level) => level.name.toLowerCase() == input.toLowerCase(),
        orElse: () => ReservationStatus.pending,
      );
}
