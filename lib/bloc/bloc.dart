import 'dart:async';
import 'dart:developer' as developer;

import 'package:audioplayers/audioplayers.dart';
// import 'package:audioplayers/audio_cache.dart';
import 'package:bloc/bloc.dart';
import 'state.dart';
part 'event.dart';

class AppBlocBloc extends Bloc<AppEvent, AppState> {
  int page;
  List<AudioPlayer> players =
      List.generate(2, (_) => AudioPlayer()..setReleaseMode(ReleaseMode.stop));
  int selectedPlayerIdx = 0;

  AudioPlayer get selectedPlayer => players[selectedPlayerIdx];
  List<StreamSubscription> streams = [];

  AppBlocBloc({
    required this.page,
  }) : super(AppState.update(
          page: page,
          counter: 0,
          wrong: 0,
          good: 0,
          target: 0,
          buttomPressed: false,
          buttonHelpPressed: false,
          truePosition: 0,
        )) {
    on<PressButtonChoiseEvent>((event, emit) {
      developer.log('Event - PressButtonChoiseEvent');
      state.counter++;
      state.buttomPressed = true;
      state.buttonChoise = event.choise;
      if (event.choise == state.truePosition) {
        state.good++;

        AudioPlayer(playerId: '/assets/sound/correct.mp3').audioCache;
      } else {
        state.wrong++;
        AudioPlayer(playerId: '/assets/sound/error-2.mp3').audioCache;
      }
      // emit(AppState.update(
      //   page: state.page,
      //   counter: state.counter,
      //   wrong: state.wrong,
      //   good: state.good,
      //   buttomPressed: false,
      //   target: state.target,
      //   truePosition: state.truePosition,
      //   buttonHelpPressed: true,
      // ));
      emit(AppState(
        counter: state.counter,
        buttomPressed: true,
        buttonHelpPressed: true,
        buttonChoise: state.buttonChoise,
        wrong: state.wrong,
        good: state.good,
        target: state.target,
        page: state.page,
        truePosition: state.truePosition,
        textButton: state.textButton,
      ));
    });
    on<PressButtonHelpEvent>((event, emit) {
      state.buttonHelpPressed = true;
      developer.log('Event - PressButtonHelpEvent');
      emit(AppState(
        counter: state.counter,
        buttomPressed: false,
        buttonHelpPressed: true,
        buttonChoise: state.buttonChoise,
        wrong: state.wrong,
        good: state.good,
        target: state.target,
        page: state.page,
        truePosition: state.truePosition,
        textButton: state.textButton,
      ));
    });
    on<UpdateScreenEvent>((event, emit) {
      state.buttomPressed = false;
      developer.log('Event - UpdateScreenEvent');
      emit(AppState.update(
        counter: state.counter,
        buttomPressed: false,
        buttonHelpPressed: false,
        wrong: state.wrong,
        good: state.good,
        target: state.target,
        page: state.page,
        truePosition: state.truePosition,
      ));
    });
    updateData() {
      emit(AppState.update(
        counter: state.counter,
        buttomPressed: false,
        buttonHelpPressed: false,
        wrong: state.wrong,
        good: state.good,
        target: state.target,
        page: state.page,
        truePosition: state.truePosition,
      ));
      developer.log('Test function');
    }
  }
}
