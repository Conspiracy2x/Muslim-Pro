import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_pro/pages/hadees_page.dart';
import 'package:muslim_pro/pages/haram_foods.dart';
import 'package:muslim_pro/utils/gradientTheme.dart';

import 'daily_duas.dart';

class ZikrPage extends StatelessWidget {
  const ZikrPage({super.key});

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
        title: const Text('Zikr Page'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const DailyDuas();
                    },
                  ),
                );
              },
              child: Card(
                surfaceTintColor: Theme.of(context).primaryColor,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
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
                        'Duas',
                        style: Theme.of(context).textTheme.displayLarge!,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const HadeesPage();
                    },
                  ),
                );
              },
              child: Card(
                surfaceTintColor: Theme.of(context).primaryColor,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  height: 120.h,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/hadees.png',
                        height: 70.h,
                        width: 70.w,
                      ),
                      Text(
                        'Hadees',
                        style: Theme.of(context).textTheme.displayLarge!,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HaramFoodsPage();
                    },
                  ),
                );
              },
              child: Card(
                surfaceTintColor: Theme.of(context).primaryColor,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  height: 120.h,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/haram.png',
                        height: 70.h,
                        width: 70.w,
                      ),
                      Text(
                        'Haram Foods',
                        style: Theme.of(context).textTheme.displayLarge!,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
