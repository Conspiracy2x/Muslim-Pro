import 'dart:async';

import 'package:flutter/material.dart';

class TimerNotifier extends ChangeNotifier {
  String currentNamaz = "";
  String hours = "00";
  String minutes = "00";
  String seconds = "00";
  late Timer _timer;

  void startTimer(Map<String, dynamic> prayerTimes) {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      calculateRemainingTime(prayerTimes);
    });
  }

  void calculateRemainingTime(Map<String, dynamic> prayerTimes) {
    final now = DateTime.now();

    // Filter prayer times to include only Fajr, Dhuhr, Asr, Maghrib, and Isha
    final filteredPrayerTimes = Map.fromEntries(
      prayerTimes.entries.where(
        (entry) =>
            ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'].contains(entry.key),
      ),
    );

    final List<DateTime> times = [];

    // Convert filtered prayer times into DateTime objects
    filteredPrayerTimes.forEach((key, value) {
      final parts = value.split(":");
      times.add(
        DateTime(now.year, now.month, now.day, int.parse(parts[0]),
            int.parse(parts[1])),
      );
    });

    // Handle day rollover (e.g., Fajr after midnight)
    times.add(times.first.add(const Duration(days: 1)));

    for (var i = 0; i < times.length; i++) {
      if (now.isBefore(times[i])) {
        final nextTime = times[i];
        final remaining = nextTime.difference(now);

        currentNamaz =
            filteredPrayerTimes.keys.elementAt(i % filteredPrayerTimes.length);
        hours = remaining.inHours.toString().padLeft(2, '0');
        minutes = remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
        seconds = remaining.inSeconds.remainder(60).toString().padLeft(2, '0');

        notifyListeners();
        break;
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
