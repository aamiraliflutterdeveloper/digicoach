class Holiday {
  final String id;
  final String clubId;
  final DateTime holidaysFrom;
  final DateTime holidaysTo;

const  Holiday({
    required this.id,
    required this.clubId,
    required this.holidaysFrom,
    required this.holidaysTo,
  });


  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
      id: json['id'] ,
      clubId: json['clubId'] ,
      holidaysFrom: json['holidaysFrom'] ,
      holidaysTo: json['holidaysTo'] ,
    );
  Map<String, dynamic> toJson() => {
      'id': id,
      'clubId': clubId,
      'holidaysFrom': holidaysFrom,
      'holidaysTo': holidaysTo,
    };

}
