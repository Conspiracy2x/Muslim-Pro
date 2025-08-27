String convertTo12HourFormat(String time24hr) {
  final parts = time24hr.split(':');
  final hour = int.parse(parts[0]);
  final minute = parts[1];
  final period = hour >= 12 ? 'PM' : 'AM';
  final hour12 = hour % 12 == 0 ? 12 : hour % 12;
  return '$hour12:$minute $period';
}

DateTime parseTimeToDateTime(String time12hr) {
  final now = DateTime.now();
  final timeParts = time12hr.split(' ');
  final time = timeParts[0]; // Extract the time part (e.g., "5:02")
  final period = timeParts[1]; // Extract the period (e.g., "AM" or "PM")

  final parts = time.split(':');
  int hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);

  // Convert to 24-hour format if necessary
  if (period == 'PM' && hour != 12) {
    hour += 12;
  } else if (period == 'AM' && hour == 12) {
    hour = 0;
  }

  return DateTime(now.year, now.month, now.day, hour, minute);
}
