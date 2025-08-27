import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim_pro/pages/theme_provider.dart';
import 'package:muslim_pro/utils/gradientTheme.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

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
        title: const Text('Settings'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(height: 20.h),
          // Toggle button for theme
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: context.watch<ThemeProvider>().themeMode == ThemeMode.dark,
            onChanged: (value) {
              // Change the theme
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
        ],
      )),
    );
  }
}
