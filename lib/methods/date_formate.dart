import 'package:intl/intl.dart';

String formatDate(String dateString) {
  DateTime inputDate = DateTime.parse(dateString);
  DateTime now = DateTime.now();

  // Calculate difference in days between today and the input date
  Duration difference = now.difference(inputDate);

  if (difference.inDays == 0 && now.day == inputDate.day) {
    return 'Today';
  } else if (difference.inDays == 1 ||
      (difference.inDays == 0 && now.day != inputDate.day)) {
    return 'Yesterday';
  } else {
    return DateFormat('E, dd MMM').format(inputDate);
  }
}
