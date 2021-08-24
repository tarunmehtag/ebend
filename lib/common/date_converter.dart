import 'package:intl/intl.dart';

class DateConverter {
  static String dateToString(DateTime date, String format) {
    DateFormat formatter = DateFormat(format);
    String string = formatter.format(date);
    return string;
  }

  static DateTime stringToDate(String date, String format) {
    DateFormat formatter = DateFormat(format);
    DateTime convertedDate = formatter.parse(date);
    return convertedDate;
  }
}