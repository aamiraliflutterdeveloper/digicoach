import 'package:intl/intl.dart' show DateFormat;

class Utils {
  static bool isUrlValid(String url) =>
      Uri.tryParse(url)?.hasAbsolutePath ?? false;

  static String toDateTime(DateTime dateTime) {
    final date = DateFormat.yMd().format(dateTime);
    final time = DateFormat.jm().format(dateTime);

    return '$date - $time';
  }

  static String toDate(DateTime dateTime) => DateFormat.yMd().format(dateTime);

  static String toTime(DateTime dateTime) => DateFormat.jm().format(dateTime);

  /// `hh:mm`
  static String toTimeHm(DateTime dateTime) => DateFormat.Hm().format(dateTime);

  /// 2000-01-01
  static String toDateYYMMDD(DateTime dateTime) =>
      DateFormat('yyyy-MM-dd').format(dateTime);

  static DateTime time(int hours, [int minutes = 0]) =>
      DateTime(2100, 1, 1, hours, minutes);
}
