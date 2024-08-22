import 'package:intl/intl.dart';

class StaticUtils {
  static String formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }
}
