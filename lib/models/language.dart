import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Language extends Equatable {
  int id;
  String name;
  String image;
  String languageCode;
  bool reversMap;
  bool soundOn;
  double volume;
  double rate;
  double pitch;

  Language(
      {required this.id,
      required this.name,
      required this.image,
      required this.languageCode,
      required this.reversMap,
      required this.soundOn,
      required this.volume,
      required this.rate,
      required this.pitch});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['languageCode'] = languageCode;
    map['reversMap'] = reversMap;
    map['soundOn'] = soundOn;
    map['volume'] = volume;
    map['rate'] = rate;
    map['pitch'] = pitch;
    return map;
  }

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      languageCode: map['languageCode'],
      reversMap: (map['reversMap'] != 0) ? true : false,
      soundOn: (map['soundOn'] != 0) ? true : false,
      volume: map['volume'],
      rate: map['rate'],
      pitch: map['pitch'],
    );
  }
  static List<Language> getAll() {
    return <Language>[
      Language(
        id: 0,
        name: 'English (US)',
        image: 'assets/images/flags/us.png',
        languageCode: 'en-US',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 1,
        name: 'Malay',
        image: 'assets/images/flags/ms.png',
        languageCode: 'ms-MY',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 2,
        name: 'Français (France)',
        image: 'assets/images/flags/fr.png',
        languageCode: 'fr-FR',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 3,
        name: 'Türkçe',
        image: 'assets/images/flags/tr.png',
        languageCode: 'tr-TR',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 4,
        name: 'Deutsch',
        image: 'assets/images/flags/de.png',
        languageCode: 'de-DE',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 5,
        name: '中文 (台灣)',
        image: 'assets/images/flags/jp.png',
        languageCode: 'ja-JP',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 6,
        name: 'Italiano',
        image: 'assets/images/flags/it.png',
        languageCode: 'it-IT',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 7,
        name: 'Русский',
        image: 'assets/images/flags/ru.png',
        languageCode: 'ru-RU',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 8,
        name: 'Українська',
        image: 'assets/images/flags/ua.png',
        languageCode: 'uk-UA',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
    ];
  }

  @override
  List<Object?> get props => [id, languageCode];
}
