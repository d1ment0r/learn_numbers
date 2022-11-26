import 'package:learn_numbers/models/language.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:learn_numbers/models/globals.dart' as globals;
import 'dart:developer' as console;

TextToSpeech tts = TextToSpeech();

Future<void> speech(sayText, page) async {
  if (globals.voice == null || globals.voice == '') {
    console.log(
        '\u001b[1;33mSpeech:\u001b[1;34m speech \u001b[0mvoice is \u001b[1;31mnull');
    return;
  }

  // String voice = '';
  // List<String> translateCodes = <String>[];
  Language? language = globals.currentLanguage;

  // populate lang code (i.e. en-US)
  // translateCodes = await tts.getLanguages();

  // populate displayed language (i.e. English)
  // final List<String>? displayLanguages = await tts.getDisplayLanguages();
  // if (displayLanguages == null) {
  //   return;
  // }

  // languages.clear();
  // for (final dynamic lang in displayLanguages) {
  //   languages.add(lang as String);
  // }

  // final String? defaultLangCode = await tts.getDefaultLanguage();

  // if (language!.voiceCode != '' &&
  //     translateCodes.contains(language.voiceCode)) {
  //   voice = language.voiceCode;
  // } else {
  //   voice = defaultLangCode.toString();
  // }

  // final String? displayLanguage = await tts.getDisplayLanguageByCode(voice);

  tts.setVolume(language!.volume);
  tts.setRate(language.rate);
  // if (voice != '') {
  tts.setLanguage(globals.voice!);
  console.log(
      '\u001b[1;33mSpeech: \u001b[1;34mspeech \u001b[0mvoice set: \u001b[1;32m${globals.voice}');
  // } else {
  //   tts.setLanguage(defaultLangCode!);
  //   console.log('State: voice set: $defaultLangCode');
  // }
  tts.setPitch(globals.pitch);
  // await Future.delayed(const Duration(milliseconds: 500));
  if (page == globals.currentPage) {
    tts.speak(sayText);
  }
  console.log(
      '\u001b[1;33mSpeech: \u001b[1;34mspeech page: \u001b[1;32m$page \u001b[0mcurrentPage: \u001b[1;32m${globals.currentPage}');
}
