import 'package:intl/intl.dart';

DateFormat formatter = DateFormat('dd MMM yy');
DateFormat ddMMMyyyformatter = DateFormat('dd MMMM yyy');
final weekdays = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

extension DateTimeExtension on DateTime {
  String deliveredTime() {
    final token = toIso8601String().split("T").last.split(".").first.split(":");
    return "${token[0]}:${token[1]}";
  }

  String get formattedDateTime {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays == 0) {
      return formatTime(); // Today
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return weekdays[weekday - 1]; // Within this week
    } else {
      return formatter.format(this); // Other dates
    }
  }

  String get formattedDate {
    final now = DateTime.now();
    final thisDate = DateTime(year, month, day);
    final nowDate = DateTime(now.year, now.month, now.day);
    final difference = nowDate.difference(thisDate).inDays;

    if (difference == 0) {
      return 'Today, ${formatter.format(this)}';
    } else if (difference == 1) {
      return 'Yesterday, ${formatter.format(this)}'; // Added date
    } else if (difference == -1) {
      return 'Tomorrow, ${formatter.format(this)}';
    } else if (difference < 7 && difference > 0) {
      return weekdays[weekday - 1]; // Within past week
    } else {
      return ddMMMyyyformatter.format(this);
    }
  }

  String formatTime() {
    final token = toIso8601String().split("T").last.split(".").first.split(":");
    return "${token[0]}:${token[1]}";
  }
}
