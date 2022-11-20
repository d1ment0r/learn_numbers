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
      reversMap: map['reversMap'],
      soundOn: map['soundOn'],
      volume: map['volume'],
      rate: map['rate'],
      pitch: map['pitch'],
    );
  }

  @override
  List<Object?> get props => [id, languageCode];
}
