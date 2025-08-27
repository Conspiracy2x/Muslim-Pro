import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_pro/models/DuaModel.dart';
import 'package:muslim_pro/models/HadithModel.dart';

class HadithService extends ChangeNotifier {
  var baseUrl = "https://random-hadith-generator.vercel.app/";

  String narratedBy = '';
  String hadith = '';
  String refNo = '';
  bool isLoading = false;

  List<String> books = [
    "bukhari",
    "muslim",
    "abudawud",
    "tirmidhi",
    "ibnmajah"
  ];

  String randomBook() {
    return books[Random.secure().nextInt(books.length)];
  }

  Future getHadith() async {
    isLoading = true;
    var book = randomBook();
    var url = "$baseUrl$book";
    var response = await http.get(Uri.parse(url));
    isLoading = false;
    notifyListeners();
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      HadithModel hadithModel = HadithModel.fromJson(data);
      narratedBy = hadithModel.data!.header == null
          ? ''
          : hadithModel.data!.header!.split(":")[0];
      notifyListeners();
      hadith = hadithModel.data!.hadithEnglish!;
      notifyListeners();
      refNo = hadithModel.data!.refno ?? '';
      notifyListeners();
      return;
    }
  }

  final List<DuaModel> duaList = [];
  final DuaModel dua = DuaModel(data: []);

  getDua() {
    var random = Random.secure().nextInt(duaList[0].data!.length);
    var data = duaList[0].data![random];
    dua.data!.add(data);
    notifyListeners();
  }

  prepareDua() async {
    final String response = await rootBundle.loadString('assets/dua.json');
    final data = jsonDecode(response);

    DuaModel duaModel = DuaModel.fromJson(data);
    duaList.add(duaModel);
    getDua();
  }

  var prayerTimes;

  Future<Map<String, dynamic>> fetchPrayerTimes(
      String city, String country) async {
    final url =
        'https://api.aladhan.com/v1/timingsByCity?city=$city&country=$country';
    final response = await http.get(Uri.parse(url));
    print(url);

    if (response.statusCode == 200) {
      prayerTimes = json.decode(response.body)['data']['timings'];
      print("Prayer time: $prayerTimes");
      notifyListeners();
      return json.decode(response.body)['data']['timings'];
    } else {
      throw Exception('Failed to load prayer times');
    }
  }
}
