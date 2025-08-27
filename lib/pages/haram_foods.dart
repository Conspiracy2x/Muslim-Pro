import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HaramFoodsPage extends StatelessWidget {
  final List<String> haramFoods = [
    'Pork and its by-products',
    'Alcohol and intoxicants',
    'Carnivorous animals (e.g., lions, tigers)',
    'Meat of animals not slaughtered according to Islamic rites',
    'Blood and blood products',
    'Dead animals (except fish and locusts)',
    'Foods containing gelatin derived from non-halal sources',
    'Foods contaminated with haram substances',
  ];

  HaramFoodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Haram Foods',
            style: Theme.of(context).textTheme.displayLarge!),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
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
                          'assets/haram.png',
                          height: 70.h,
                          width: 70.w,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Haram Foods',
                          style: Theme.of(context).textTheme.displayLarge!,
                        ),
                      ],
                    ),
                  )),
              ListView.builder(
                itemCount: haramFoods.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: const Icon(Icons.block, color: Colors.red),
                      title: Text(
                        haramFoods[index],
                        style: Theme.of(context).textTheme.bodyLarge!,
                      ),
                      subtitle: Text(
                        'Avoid consuming this item.',
                        style: Theme.of(context).textTheme.titleMedium!,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
