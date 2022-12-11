import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Language extends Equatable {
  int id;
  String name;
  String image;
  String translateCode;
  String voiceCode;
  bool reversMap;
  bool soundOn;
  double volume;
  double rate;
  double pitch;

  Language(
      {required this.id,
      required this.name,
      required this.image,
      required this.translateCode,
      required this.voiceCode,
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
    map['translateCode'] = translateCode;
    map['voiceCode'] = voiceCode;
    map['reversMap'] = reversMap ? 1 : 0;
    map['soundOn'] = soundOn ? 1 : 0;
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
      translateCode: map['translateCode'],
      voiceCode: map['voiceCode'],
      reversMap: (map['reversMap'] != 0) ? true : false,
      soundOn: (map['soundOn'] != 0) ? true : false,
      volume: map['volume'],
      rate: map['rate'],
      pitch: map['pitch'],
    );
  }

  factory Language.getDefault() {
    List<Language> listLanguage = getAll();
    return listLanguage[5];
  }

  factory Language.getClean() {
    return Language(
      id: 0,
      name: '',
      image: '',
      translateCode: '',
      voiceCode: '',
      reversMap: false,
      soundOn: true,
      volume: 1,
      rate: 1,
      pitch: 1,
    );
  }

  static List<Language> getAll() {
    return <Language>[
      Language(
        id: 0,
        name: 'Bulgarian',
        image: 'assets/images/flags/bg.png',
        translateCode: 'bg',
        voiceCode: 'bg-BG',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 1,
        name: 'Chinese (simplified)',
        image: 'assets/images/flags/cn.png',
        translateCode: 'zh-cn',
        voiceCode: 'zh-CN',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 2,
        name: 'Chinese (traditional)',
        image: 'assets/images/flags/cn.png',
        translateCode: 'zh-tw',
        voiceCode: 'zh-TW',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 3,
        name: 'Croatian',
        image: 'assets/images/flags/hr.png',
        translateCode: 'hr',
        voiceCode: 'hr-HR',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 4,
        name: 'Czech',
        image: 'assets/images/flags/cs.png',
        translateCode: 'cs',
        voiceCode: 'cs-CS',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 5,
        name: 'English',
        image: 'assets/images/flags/us.png',
        translateCode: 'en',
        voiceCode: 'en-US',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 6,
        name: 'Estonian',
        image: 'assets/images/flags/et.png',
        translateCode: 'et',
        voiceCode: 'et-ET',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 7,
        name: 'Finnish',
        image: 'assets/images/flags/fi.png',
        translateCode: 'fi',
        voiceCode: 'fi-FI',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 8,
        name: 'French',
        image: 'assets/images/flags/fr.png',
        translateCode: 'fr',
        voiceCode: 'fr-FR',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 9,
        name: 'Georgian',
        image: 'assets/images/flags/gr.png',
        translateCode: 'ka',
        voiceCode: 'ka-KA',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 10,
        name: 'German',
        image: 'assets/images/flags/de.png',
        translateCode: 'de',
        voiceCode: 'de-DE',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 11,
        name: 'Italian',
        image: 'assets/images/flags/it.png',
        translateCode: 'it',
        voiceCode: 'it-IT',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 12,
        name: 'Latvian',
        image: 'assets/images/flags/lv.png',
        translateCode: 'lv',
        voiceCode: 'lv-LV',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 13,
        name: 'Malay',
        image: 'assets/images/flags/ms.png',
        translateCode: 'ms',
        voiceCode: 'ms-MY',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 14,
        name: 'Polish',
        image: 'assets/images/flags/pl.png',
        translateCode: 'pl',
        voiceCode: 'pl-PL',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 15,
        name: 'Portuguese',
        image: 'assets/images/flags/pt.png',
        translateCode: 'pt',
        voiceCode: 'pt-PT',
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
        translateCode: 'ro',
        voiceCode: 'ro-RO',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 17,
        name: 'Russian',
        image: 'assets/images/flags/ru.png',
        translateCode: 'ru',
        voiceCode: 'ru-RU',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 18,
        name: 'Serbian',
        image: 'assets/images/flags/sr.png',
        translateCode: 'sr',
        voiceCode: 'sr-SR',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 19,
        name: 'Spanish',
        image: 'assets/images/flags/es.png',
        translateCode: 'es',
        voiceCode: 'es-ES',
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
        translateCode: 'th',
        voiceCode: 'th-TH',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 21,
        name: 'Turkish',
        image: 'assets/images/flags/tr.png',
        translateCode: 'tr',
        voiceCode: 'tr-TR',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
      Language(
        id: 22,
        name: 'Ukrainian',
        image: 'assets/images/flags/ua.png',
        translateCode: 'uk',
        voiceCode: 'uk-UA',
        reversMap: false,
        soundOn: true,
        volume: 1,
        rate: 1,
        pitch: 1,
      ),
    ];
  }

  @override
  List<Object?> get props => [id, translateCode];
}
