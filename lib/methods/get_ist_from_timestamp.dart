import 'package:intl/intl.dart';

String getISTTimeFromTimestamp(int timestamp) {
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);

  dateTime = dateTime.add(const Duration(hours: 5, minutes: 30));

  final DateFormat formatter = DateFormat('hh:mm a');
  return formatter.format(dateTime);
}
