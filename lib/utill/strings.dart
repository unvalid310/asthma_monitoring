import 'package:intl/intl.dart';

String getFormattedDate(DateTime date) {
  final dateFormat = DateFormat('d MMMM yyyy', "en_US").format(date);
  return dateFormat.toString();
}

String getShortDate(DateTime date) {
  final dateFormat = DateFormat('yyyy-MM-dd', "en_US").format(date);
  return dateFormat.toString();
}

String getTime(DateTime date) {
  final dateFormat = DateFormat('hh:mm', 'en_US').format(date);
  return dateFormat.toString();
}
