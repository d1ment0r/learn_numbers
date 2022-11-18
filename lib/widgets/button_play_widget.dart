import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:learn_numbers/bloc/bloc.dart';
import 'package:learn_numbers/bloc/state.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:learn_numbers/models/globals.dart' as globals;

class ButtonPlayWidget extends StatefulWidget {
  const ButtonPlayWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ButtonPlayWidget> createState() => _ButtonPlayWidgetState();
}

class _ButtonPlayWidgetState extends State<ButtonPlayWidget> {
  final String defaultLanguage = 'tr';
  String text = '';
  double volume = 1; // Range: 0-1
  double rate = 0.8; // Range: 0-2
  double pitch = 1.2; // Range: 0-2

  String? language;
  String? languageCode;
  List<String> languages = <String>[];
  List<String> languageCodes = <String>[];
  String? voice;

  TextToSpeech tts = TextToSpeech();

  @override
  void initState() {
    super.initState();
    initLanguages();
  }

  Future<void> initLanguages() async {
    // populate lang code (i.e. en-US)
    languageCodes = await tts.getLanguages();

    // populate displayed language (i.e. English)
    final List<String>? displayLanguages = await tts.getDisplayLanguages();
    if (displayLanguages == null) {
      return;
    }

    languages.clear();
    for (final dynamic lang in displayLanguages) {
      languages.add(lang as String);
    }

    final String? defaultLangCode = await tts.getDefaultLanguage();
    if (defaultLangCode != null && languageCodes.contains(defaultLangCode)) {
      languageCode = defaultLangCode;
    } else {
      languageCode = defaultLanguage;
    }
    languageCode = 'tr';
    language = await tts.getDisplayLanguageByCode(languageCode!);

    /// get voice
    voice = await getVoiceByLang(languageCode!);

    if (mounted) {
      setState(() {});
    }
  }

  Future<String?> getVoiceByLang(String lang) async {
    final List<String>? voices = await tts.getVoiceByLang(languageCode!);
    if (voices != null && voices.isNotEmpty) {
      return voices.first;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BlocConsumer<AppBlocBloc, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                // speak(state.target.toString());
                speak(globals.sortingMap[state.target]);
                // context
                //     .read<AppBlocBloc>()
                //     .add(PressButtonHelpEvent(state.target));
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                  // image: const DecorationImage(
                  //   image: Svg(
                  //     'assets/images/sound_ok.svg',
                  //     size: Size(30.0, 30.0),
                  //     color: Color(0xFF3399CC),
                  //   ),
                  // ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(4, 4),
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(-4, -4),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  speak(sayText) {
    tts.setVolume(volume);
    tts.setRate(rate);
    if (languageCode != null) {
      tts.setLanguage(languageCode!);
    }
    tts.setPitch(pitch);
    tts.speak(sayText);
    tts.resume();
  }
}
