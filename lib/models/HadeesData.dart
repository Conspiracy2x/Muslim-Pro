/// book : "Sahih Muslim"
/// bookName : "\n\t\t\t\tThe Book of Prayer - Friday\t\t\t"
/// chapterName : "Chapter: Keeping the prayer and khutbah short"
/// hadith_english : "I memorised (surah) \"Qaf, by the glorious Qur'an\" from the mouth of the Messenger of Allah (ﷺ) on Friday for he recited it on the pulpit on every Friday."
/// header : "\n'Amra daughter of Abd al-Rahman reported on the authority of the sister of Amra:"
/// id : 872
/// refno : "Sahih Muslim 872 a"
library;

class Data {
  Data({
    String? book,
    String? bookName,
    String? chapterName,
    String? hadithEnglish,
    String? header,
    num? id,
    String? refno,
  }) {
    _book = book;
    _bookName = bookName;
    _chapterName = chapterName;
    _hadithEnglish = hadithEnglish;
    _header = header;
    _id = id;
    _refno = refno;
  }

  Data.fromJson(dynamic json) {
    _book = json['book'];
    _bookName = json['bookName'];
    _chapterName = json['chapterName'];
    _hadithEnglish = json['hadith_english'];
    _header = json['header'];
    _id = json['id'];
    _refno = json['refno'];
  }

  String? _book;
  String? _bookName;
  String? _chapterName;
  String? _hadithEnglish;
  String? _header;
  num? _id;
  String? _refno;

  Data copyWith({
    String? book,
    String? bookName,
    String? chapterName,
    String? hadithEnglish,
    String? header,
    num? id,
    String? refno,
  }) =>
      Data(
        book: book ?? _book,
        bookName: bookName ?? _bookName,
        chapterName: chapterName ?? _chapterName,
        hadithEnglish: hadithEnglish ?? _hadithEnglish,
        header: header ?? _header,
        id: id ?? _id,
        refno: refno ?? _refno,
      );

  String? get book => _book;

  String? get bookName => _bookName;

  String? get chapterName => _chapterName;

  String? get hadithEnglish => _hadithEnglish;

  String? get header => _header;

  num? get id => _id;

  String? get refno => _refno;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['book'] = _book;
    map['bookName'] = _bookName;
    map['chapterName'] = _chapterName;
    map['hadith_english'] = _hadithEnglish;
    map['header'] = _header;
    map['id'] = _id;
    map['refno'] = _refno;
    return map;
  }
}
