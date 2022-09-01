import 'package:intl/intl.dart';

class DateFormatHelper {
  static String formatInviteDate(String time) {
    final DateTime _time = DateTime.parse(time);
    return DateFormat("dd/MM/yyyy").format(_time.toLocal());
  }

  static String formatDateInQuery({required String time}) {
    final DateTime _time = DateTime.parse(time);
    return DateFormat.yMMMd('en_US').format(_time);
  }

  static String formatDOBDate({required String time}) {
    final DateTime _time = DateTime.parse(time);
    return DateFormat("dd-MM-yyyy").format(_time);
  }

  static String formatDateWithTimeStamp({required String time}) {
    final DateTime _time = DateTime.parse(time);
    return DateFormat('jm').format(_time);
  }
}