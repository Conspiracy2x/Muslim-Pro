import 'HadeesData.dart';

/// data : {"book":"Sahih Muslim","bookName":"\n\t\t\t\tThe Book of Prayer - Friday\t\t\t","chapterName":"Chapter: Keeping the prayer and khutbah short","hadith_english":"I memorised (surah) \"Qaf, by the glorious Qur'an\" from the mouth of the Messenger of Allah (ﷺ) on Friday for he recited it on the pulpit on every Friday.","header":"\n'Amra daughter of Abd al-Rahman reported on the authority of the sister of Amra:","id":872,"refno":"Sahih Muslim 872 a"}

class HadithModel {
  HadithModel({
    Data? data,
  }) {
    _data = data;
  }

  HadithModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Data? _data;

  HadithModel copyWith({
    Data? data,
  }) =>
      HadithModel(
        data: data ?? _data,
      );

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}
