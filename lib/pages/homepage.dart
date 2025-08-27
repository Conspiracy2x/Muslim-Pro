import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:muslim_pro/service/hadith_service.dart';
import 'package:muslim_pro/pages/timer_notifier.dart';
import 'package:provider/provider.dart';

import '../utils/date_handler.dart';
import '../utils/gradientTheme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateTime time = DateTime.now();
  String _currentNamaz = "";
  String _hours = "";
  String _minutes = "";
  String _seconds = "";

  final hijriDate = HijriCalendar.now();
  final String _location = "London , UK";

  getDua() async {
    await context.read<HadithService>().prepareDua();
  }

  getNamaz() async {
    await context.read<HadithService>().fetchPrayerTimes("London", "UK");
    // calculateNamazTime();
  }

  //Calculate currentNamaz and the time reaming for the next namaz

  void calculateNamazTime() {
    final now = DateTime.now();
    final prayerTimes = context.read<HadithService>().prayerTimes;

    print("Called calculateNamazTime");
    print(prayerTimes);

    // Filter prayer times to include only Fajr, Zuhr, Asr, Maghrib, and Isha
    final filteredPrayerTimes = Map.fromEntries(
      prayerTimes.entries.where((entry) =>
          ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'].contains(entry.key)),
    );

    final List keys = filteredPrayerTimes.keys.toList();
    final List values = filteredPrayerTimes.values.toList();
    final List<DateTime> prayerTimesList = [];

    // Parse prayer times into DateTime objects
    for (int i = 0; i < keys.length; i++) {
      final timeParts = values[i].split(":");
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      // Add prayer time for today
      prayerTimesList.add(DateTime(now.year, now.month, now.day, hour, minute));
    }

    // Handle day rollover (e.g., Fajr after midnight)
    prayerTimesList.add(prayerTimesList.first.add(const Duration(days: 1)));

    // Find the next prayer time
    for (int i = 0; i < prayerTimesList.length; i++) {
      if (now.isBefore(prayerTimesList[i])) {
        final currentPrayerIndex = i % keys.length; // Loop back for Fajr
        final currentPrayer = keys[currentPrayerIndex];

        final timeDifference = prayerTimesList[i].difference(now);
        final hours = timeDifference.inHours;
        final minutes = timeDifference.inMinutes.remainder(60);
        final seconds = timeDifference.inSeconds.remainder(60);

        setState(() {
          _currentNamaz = currentPrayer;
          _hours = hours.toString().padLeft(2, '0');
          _minutes = minutes.toString().padLeft(2, '0');
          _seconds = seconds.toString().padLeft(2, '0');
        });

        print("Current Namaz: $currentPrayer");
        print("Time Remaining: $hours:$minutes:$seconds");
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initializeData();
      getDua();
      final prayerTimes = await context.read<HadithService>().prayerTimes;
      context.read<TimerNotifier>().startTimer(prayerTimes);
    });
  }

  Future<void> initializeData() async {
    await getNamaz(); // Call after _determinePosition
  }

  @override
  Widget build(BuildContext context) {
    final gradient = Theme.of(context).extension<GradientTheme>()!.cardGradient;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: gradient,
          ),
        ),
        title: const Text('Muslim Pro'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder(
            future: context.read<HadithService>().getHadith(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              }
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }

              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/main.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Muslim Pro",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        Center(
                          child: Text(
                            "The most accurate prayer time app",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        Center(
                          child: Text(
                            _location,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    children: [
                      Card(
                        elevation: 8, // Increased shadow
                        shadowColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              12.r), // Smooth rounded corners
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            gradient: gradient,
                          ),
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Date Section
                              Column(
                                children: [
                                  Text(
                                    "${days[time.weekday]!.substring(0, 3)}, ${time.day} ${months[time.month]!.substring(0, 3)}, ${time.year}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    "${hijriDate.hDay} ${hijriDate.longMonthName}, ${hijriDate.hYear}",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),

                              // Next Prayer Section
                              Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Consumer<TimerNotifier>(
                                  builder: (context, timerNotifier, child) =>
                                      Column(
                                    children: [
                                      Text(
                                        "Next Prayer",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        timerNotifier.currentNamaz,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: 24.sp,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.green.shade800
                                                  : Colors.amber.shade300,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),

                                      Divider(
                                          color: Colors.grey.shade300,
                                          thickness: 1),
                                      Text(
                                        "Time Left in ${timerNotifier.currentNamaz}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                      ),
                                      SizedBox(height: 12.h),

                                      // Timer Section
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          _timeColumn(timerNotifier.hours,
                                              "HOURS", context),
                                          _timeColumn(timerNotifier.minutes,
                                              "MINUTES", context),
                                          _timeColumn(timerNotifier.seconds,
                                              "SECONDS", context),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  CarouselSlider(
                    items: const [
                      MyCard(),
                      DuaCard(),
                    ],
                    options: CarouselOptions(
                      height: 200.h,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      enlargeCenterPage: false,
                      viewportFraction: 0.9,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

Widget _timeColumn(String value, String unit, BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    child: Column(
      children: [
        Text(
          value,
          style: Theme.of(context).brightness == Brightness.light
              ? Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 24.sp,
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.bold,
                  )
              : Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 24.sp,
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.bold,
                  ),
        ),
        Text(
          unit,
          style: Theme.of(context).brightness == Brightness.light
              ? Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black)
              : Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.amber.shade300),
        ),
      ],
    ),
  );
}

void _showFullTextDialog(
    BuildContext context, String fullText, String header, String refNo) {
  final gradient = Theme.of(context).extension<GradientTheme>()!.cardGradient;
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(16.0.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      header,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  Center(
                    child: Text(
                      refNo,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  SizedBox(height: 12.0.h),
                  Text(
                    fullText,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : Colors.amber.shade300,
                          fontSize: 16.sp,
                        ),
                  ),
                  SizedBox(height: 16.0.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Close",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.amber.shade300,
                              fontSize: 16.sp,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final gradient = Theme.of(context).extension<GradientTheme>()!.cardGradient;
    return GestureDetector(
      onTap: () => _showFullTextDialog(
        context,
        "${context.read<HadithService>().narratedBy} ${context.read<HadithService>().hadith}",
        context.read<HadithService>().refNo,
        "Hadees of the Day",
      ),
      child: Card(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            gradient: gradient,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  "Hadees of the Day",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                ),
              ),
              Text(
                "${context.read<HadithService>().narratedBy} ${context.read<HadithService>().hadith} ",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.amber.shade300,
                      fontSize: 16.sp,
                      // overflow: TextOverflow.ellipsis,
                    ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DuaCard extends StatelessWidget {
  const DuaCard({super.key});

  @override
  Widget build(BuildContext context) {
    final gradient = Theme.of(context).extension<GradientTheme>()!.cardGradient;

    return GestureDetector(
      onTap: () => _showFullTextDialog(
        context,
        "${context.read<HadithService>().dua.data![0].arabic}\n\n${context.read<HadithService>().dua.data![0].enTranslation}",
        "Dua of the day",
        context.read<HadithService>().dua.data![0].source!,
      ),
      child: Card(
        elevation: 8,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: gradient,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Dua of the Day",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                      ),
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  context.read<HadithService>().dua.data![0].arabic!,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.amber.shade300,
                        fontSize: 16.sp,
                        // overflow: TextOverflow.ellipsis,
                      ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  // textAlign: TextAlign.end,
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                context.read<HadithService>().dua.data![0].enTranslation!,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.amber.shade300,
                      fontSize: 16.sp,
                      // overflow: TextOverflow.ellipsis,
                    ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
