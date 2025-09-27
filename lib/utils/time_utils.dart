// lib/utils/time_utils.dart
import 'package:intl/intl.dart';

class TimeUtils {
  static String formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('hh:mm a').format(date);
  }
}