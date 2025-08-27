/// data : [{"id":1,"arabic":"بِاسْمِكَ اللَّهُمَّ أَمُوْتُ وَأَحْيَا","latin":"bismika, allahumma amuutu wa ahyaa","translation":"Dengan menyebut nama-Mu, ya Allah! Aku mati dan dan hidup.","en_translation":"In Your name, O Allah, I die and I live.","source":"HR. al-Bukhari"},{"id":2,"arabic":"الحَمْدُ للهِ الَّذِي أَحْيَانَا بعْدَ مَا أماتَنَا وإِلَيْهِ النُّشُورُ","latin":"alhamdulillahilladzi ahyaanaa ba'da maa amaatanaa wa ilaihin nusyuur","translation":"Dengan menyebut nama-Mu, ya Allah! Aku mat","en_translation":"All praise is due to Allah, who gave us life after causing us to die, and to Him is the resurrection.","source":"HR. al-Bukhari"},{"id":3,"arabic":"اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْخُبُثِ وَالْخَبَائِثِ","latin":"allahumma innii a'uudzubika minal khubutsi wal khabaaitsi","translation":"Dengan menyebut nama-Mu, ya Allah! Aku mat","en_translation":"O Allah, I seek refuge in You from the male and female devils.","source":"HR. al-Bukhari"},{"id":4,"arabic":"غُفْرَانَكَ","latin":"ghuf-raanak","translation":"Aku mohon ampunan-Mu (ya Allah).","en_translation":"I seek Your forgiveness (O Allah).","source":"HR. at-Tirmidzi"},{"id":5,"arabic":"بِسْمِ اللَّهِ","latin":"bismillah","translation":"Dengan nama Allah (aku mulai makan).","en_translation":"In the name of Allah (I begin eating).","source":"HR. al-Bukari No. 5376 dan Muslim No. 2022"}]
library;

class DuaModel {
  DuaModel({
    List<Data>? data,
  }) {
    _data = data;
  }

  DuaModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? _data;
  DuaModel copyWith({
    List<Data>? data,
  }) =>
      DuaModel(
        data: data ?? _data,
      );
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// arabic : "بِاسْمِكَ اللَّهُمَّ أَمُوْتُ وَأَحْيَا"
/// latin : "bismika, allahumma amuutu wa ahyaa"
/// translation : "Dengan menyebut nama-Mu, ya Allah! Aku mati dan dan hidup."
/// en_translation : "In Your name, O Allah, I die and I live."
/// source : "HR. al-Bukhari"

class Data {
  Data({
    num? id,
    String? arabic,
    String? latin,
    String? translation,
    String? enTranslation,
    String? source,
  }) {
    _id = id;
    _arabic = arabic;
    _latin = latin;
    _translation = translation;
    _enTranslation = enTranslation;
    _source = source;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _arabic = json['arabic'];
    _latin = json['latin'];
    _translation = json['translation'];
    _enTranslation = json['en_translation'];
    _source = json['source'];
  }
  num? _id;
  String? _arabic;
  String? _latin;
  String? _translation;
  String? _enTranslation;
  String? _source;
  Data copyWith({
    num? id,
    String? arabic,
    String? latin,
    String? translation,
    String? enTranslation,
    String? source,
  }) =>
      Data(
        id: id ?? _id,
        arabic: arabic ?? _arabic,
        latin: latin ?? _latin,
        translation: translation ?? _translation,
        enTranslation: enTranslation ?? _enTranslation,
        source: source ?? _source,
      );
  num? get id => _id;
  String? get arabic => _arabic;
  String? get latin => _latin;
  String? get translation => _translation;
  String? get enTranslation => _enTranslation;
  String? get source => _source;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['arabic'] = _arabic;
    map['latin'] = _latin;
    map['translation'] = _translation;
    map['en_translation'] = _enTranslation;
    map['source'] = _source;
    return map;
  }
}
