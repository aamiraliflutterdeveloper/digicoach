import 'package:clients_digcoach/utils/utils.dart';

class OpeningTime {
  final DateTime from;
  final DateTime to;

  const OpeningTime({
    required this.from,
    required this.to,
  });

  factory OpeningTime.standard() =>
      OpeningTime(from: Utils.time(9), to: Utils.time(17));

  factory OpeningTime.fromJson(Map<String, dynamic> json) => OpeningTime(
        from: json['from'],
        to: json['to'],
      );

  Map<String, dynamic> toJson() => {
        'from': from,
        'to': to,
      };

  OpeningTime copy({
    final DateTime? from,
    final DateTime? to,
  }) =>
      OpeningTime(
        from: from ?? this.from,
        to: to ?? this.to,
      );
}
