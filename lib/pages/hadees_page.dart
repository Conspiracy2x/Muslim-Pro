import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HadeesPage extends StatelessWidget {
  const HadeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ahadith',
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
                          'assets/hadees.png',
                          height: 70.h,
                          width: 70.w,
                        ),
                        Text(
                          'Ahadith',
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
                            'Hadees 1',
                            style: Theme.of(context).textTheme.displayLarge!,
                          ),
                          subtitle: Text(
                            'Narrated Abu Huraira: The Prophet (ﷺ) said, "Faith (Belief) consists of more than sixty branches (i.e. parts). And Haya (This term "Haya" covers a large number of concepts which are to be taken together; amongst them are self respect, modesty, bashfulness, and scruple, etc.) is a part of faith."',
                            style: Theme.of(context).textTheme.bodyLarge!,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text('Hadees 2',
                              style: Theme.of(context).textTheme.displayLarge!),
                          subtitle: Text(
                            'Narrated Abu Huraira: Allah\'s Messenger (ﷺ) said, "The strong is not the one who overcomes the people by his strength, but the strong is the one who controls himself while in anger."',
                            style: Theme.of(context).textTheme.bodyLarge!,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text('Hadees 3',
                              style: Theme.of(context).textTheme.displayLarge!),
                          subtitle: Text(
                            'Narrated Abu Huraira: Allah\'s Messenger (ﷺ) said, "The deeds of anyone of you will not save you (from the (Hell) Fire)." They said, "Even you (will not be saved by your deeds), O Allah\'s Messenger (ﷺ)?" He said, "No, even I (will not be saved) unless and until Allah bestows His Mercy on me. Therefore, do good deeds properly, sincerely and moderately, and worship Allah in the forenoon and in the afternoon and during a part of the night, and always adopt a middle, moderate, regular course whereby you will reach your target (Paradise)."',
                            style: Theme.of(context).textTheme.bodyLarge!,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text('Hadees 4',
                              style: Theme.of(context).textTheme.displayLarge!),
                          subtitle: Text(
                            'Narrated Abu Huraira: Allah\'s Messenger (ﷺ) said, "The example of a believer is that of a fresh tender plant; from whatever direction the wind comes, it bends it, but when the wind becomes quiet, it becomes straight again. Similarly, a believer is afflicted with calamities (but he remains patient till Allah removes his difficulties.) And an impious wicked person is like a pine tree which keeps hard and straight till Allah cuts (breaks) it down when He wishes."',
                            style: Theme.of(context).textTheme.bodyLarge!,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text('Hadees 5',
                              style: Theme.of(context).textTheme.displayLarge!),
                          subtitle: Text(
                            "`Narrated Ibn 'Umar: Allah's Apostle said: Islam is based on (the following) five (principles): 1. To testify that none has the right to be worshipped but Allah and Muhammad is Allah's Apostle. 2. To offer the (compulsory congregational) prayers dutifully and perfectly. 3. To pay Zakat (i.e. obligatory charity) . 4. To perform Hajj. (i.e. Pilgrimage to Mecca) 5. To observe fast during the month of Ramadan. '",
                            style: Theme.of(context).textTheme.bodyLarge!,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text('Hadees 6',
                              style: Theme.of(context).textTheme.displayLarge!),
                          subtitle: Text(
                            'ِNarrated Abu Huraira: The Prophet said, Faith (Belief) consists of more than sixty branches (i.e. parts). And Haya (This term Haya covers a large number of concepts which are to be taken together; amongst them are self respect, modesty, bashfulness, and scruple, etc.) is a part of faith.',
                            style: Theme.of(context).textTheme.bodyLarge!,
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
