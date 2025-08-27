import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyDuas extends StatelessWidget {
  const DailyDuas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily Duas',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Card(
                  surfaceTintColor: Theme.of(context).primaryColor,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 120.h,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/dua.png',
                          height: 70.h,
                          width: 70.w,
                        ),
                        Text(
                          'Daily Duas',
                          style: Theme.of(context).textTheme.displayLarge!,
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text(
                            'Dua for Sleep',
                            style: Theme.of(context).textTheme.displayLarge!,
                          ),
                          subtitle: Text(
                            'بِاسْمِكَ اللَّهُمَّ أَمُوْتُ وَأَحْيَا',
                            style: Theme.of(context).textTheme.bodyLarge!,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text('Dua for Waking Up',
                              style: Theme.of(context).textTheme.displayLarge!),
                          subtitle: Text(
                            'الحَمْدُ للهِ الَّذِي أَحْيَانَا بعْدَ مَا أماتَنَا وإِلَيْهِ النُّشُور',
                            style: Theme.of(context).textTheme.bodyLarge!,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text('Dua for Entering the Toilet',
                              style: Theme.of(context).textTheme.displayLarge!),
                          subtitle: Text(
                            'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْخُبُثِ وَالْخَبَائِثِ',
                            style: Theme.of(context).textTheme.bodyLarge!,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text('Dua for Leaving the Toilet',
                              style: Theme.of(context).textTheme.displayLarge!),
                          subtitle: Text(
                            'غُفْرَانَكَ',
                            style: Theme.of(context).textTheme.bodyLarge!,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text('Dua for Entering the House',
                              style: Theme.of(context).textTheme.displayLarge!),
                          subtitle: Text(
                            'بِسْمِ اللَّه',
                            style: Theme.of(context).textTheme.bodyLarge!,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text('Dua for Leaving the House',
                              style: Theme.of(context).textTheme.displayLarge!),
                          subtitle: Text(
                            'بِسْمِ اللَّهِ تَوَكَّلْتُ عَلَى اللَّهِ وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
                            style: Theme.of(context).textTheme.bodyLarge!,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
