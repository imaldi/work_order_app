import 'package:intl/intl.dart';


bool isPlusCodeCheck(String locationName) {
  final plusCodePattern = RegExp(r'^[23456789CFGHJMPQRVWX]{4,8}\+[23456789CFGHJMPQRVWX]{2,3}$');
  return plusCodePattern.hasMatch(locationName);
}


String formatDateTime(DateTime dateTime) {
  // Dapatkan tanggal hari ini, kemarin, dan besok
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(Duration(days: 1));
  final tomorrow = today.add(Duration(days: 1));
  final inputDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

  // Formatter untuk waktu (contoh: "8.15 AM")
  final timeFormatter = DateFormat('h.mm a');

  // Formatter untuk tanggal dan waktu (contoh: "2025-Jul-04 08:15")
  final dateTimeFormatter = DateFormat('yyyy-MMM-dd hh:mm');

  // Tentukan format berdasarkan tanggal
  if (inputDate == today) {
    return 'Today, ${timeFormatter.format(dateTime)}';
  } else if (inputDate == yesterday) {
    return 'Yesterday, ${timeFormatter.format(dateTime)}';
  } else if (inputDate == tomorrow) {
    return 'Tomorrow, ${timeFormatter.format(dateTime)}';
  } else {
    return dateTimeFormatter.format(dateTime);
  }
}