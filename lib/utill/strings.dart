import 'package:intl/intl.dart';

String getFormattedDate(DateTime date) {
  final dateFormat = DateFormat('d MMMM yyyy', "en_US").format(date);
  return dateFormat.toString();
}

String getMonthFormated(DateTime date) {
  final dateFormat = DateFormat('MMMM yyyy', "en_US").format(date);
  return dateFormat.toString();
}

String getChartDate(DateTime date) {
  final dateFormat = DateFormat('dd/MM', "en_US").format(date);
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
