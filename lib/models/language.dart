import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Language extends Equatable {
  int id;
  String name;
  String image;
  String languageCode;
  String voice;
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
      required this.voice,
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
    map['voice'] = voice;
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
      voice: map['voice'],
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
        languageCode: 'en',
        voice: 'en-US',
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
        languageCode: 'ms',
        voice: 'ms-MY',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 2,
        name: 'Français',
        image: 'assets/images/flags/fr.png',
        languageCode: 'fr',
        voice: 'fr-FR',
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
        languageCode: 'tr',
        voice: 'tr-TR',
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
        languageCode: 'de',
        voice: 'de-DE',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 5,
        name: 'Czech',
        image: 'assets/images/flags/cs.png',
        languageCode: 'cs',
        voice: 'cs-CS',
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
        languageCode: 'it',
        voice: 'it-IT',
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
        languageCode: 'ru',
        voice: 'ru-RU',
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
        languageCode: 'uk',
        voice: 'uk-UA',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 9,
        name: 'Estonian',
        image: 'assets/images/flags/et.png',
        languageCode: 'et',
        voice: 'et-ET',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 10,
        name: 'Polish',
        image: 'assets/images/flags/pl.png',
        languageCode: 'pl',
        voice: 'pl-PL',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 11,
        name: 'Spanish',
        image: 'assets/images/flags/es.png',
        languageCode: 'es',
        voice: 'es-ES',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 12,
        name: 'Portuguese',
        image: 'assets/images/flags/pt.png',
        languageCode: 'pt',
        voice: 'pt-PT',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 13,
        name: 'Croatian',
        image: 'assets/images/flags/hr.png',
        languageCode: 'hr',
        voice: 'hr-HR',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 14,
        name: 'Finnish',
        image: 'assets/images/flags/fi.png',
        languageCode: 'fi',
        voice: 'fi-FI',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 15,
        name: 'Latvian',
        image: 'assets/images/flags/lv.png',
        languageCode: 'lv',
        voice: 'lv-LV',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 16,
        name: 'Romanian',
        image: 'assets/images/flags/ro.png',
        languageCode: 'ro',
        voice: 'ro-RO',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 17,
        name: 'Georgian',
        image: 'assets/images/flags/gr.png',
        languageCode: 'ka',
        voice: 'ka-KA',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 18,
        name: 'Chinese Simplified',
        image: 'assets/images/flags/cn.png',
        languageCode: 'zh-cn',
        voice: 'zh-cn',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 19,
        name: 'Chinese Traditional',
        image: 'assets/images/flags/cn.png',
        languageCode: 'zh-tw',
        voice: 'zh-tw',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 20,
        name: 'Thai',
        image: 'assets/images/flags/th.png',
        languageCode: 'th',
        voice: 'th-TH',
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
