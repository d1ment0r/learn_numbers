import 'dart:developer' as developer;
import 'package:learn_numbers/models/globals.dart' as globals;

import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:audioplayers/audio_cache.dart';
import 'state.dart';
part 'event.dart';

class AppBlocBloc extends Bloc<AppEvent, AppState> {
  int page;

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
          buttonReverse: false,
          truePosition: 0,
        )) {
    on<PressButtonChoiseEvent>((event, emit) {
      developer.log('Event - PressButtonChoiseEvent');
      state.counter++;
      state.buttomPressed = true;
      state.buttonChoise = event.choise;
      if (event.choise == state.truePosition) {
        state.good++;
      } else {
        state.wrong++;
      }
      emit(AppState(
        counter: state.counter,
        buttomPressed: true,
        buttonHelpPressed: true,
        buttonChoise: state.buttonChoise,
        buttonReverse: globals.reversMap,
        soundOn: globals.soundOn,
        wrong: state.wrong,
        good: state.good,
        target: state.target,
        page: state.page,
        truePosition: state.truePosition,
        listButton: state.listButton,
      ));
    });

    on<PressButtonHelpEvent>((event, emit) {
      state.buttonHelpPressed = true;
      developer.log('Event - PressButtonHelpEvent');
      emit(AppState.speech(
        counter: state.counter,
        buttomPressed: false,
        buttonHelpPressed: true,
        buttonChoise: state.buttonChoise,
        buttonReverse: state.buttonReverse,
        wrong: state.wrong,
        soundOn: globals.soundOn,
        good: state.good,
        target: state.target,
        page: state.page,
        truePosition: state.truePosition,
        listButton: state.listButton,
      ));
    });

    on<ChangeSoundStateEvent>((event, emit) {
      if (globals.soundOn) {
        developer.log('Event - ChangeSoundStateEvent, sound: on');
      } else {
        developer.log('Event - ChangeSoundStateEvent, sound: off');
      }
      emit(AppState.speech(
        counter: state.counter,
        buttomPressed: state.buttomPressed,
        buttonHelpPressed: state.buttonHelpPressed,
        buttonChoise: state.buttonChoise,
        buttonReverse: state.buttonReverse,
        wrong: state.wrong,
        soundOn: globals.soundOn,
        good: state.good,
        target: state.target,
        page: state.page,
        truePosition: state.truePosition,
        listButton: state.listButton,
      ));
    });

    on<PressButtonReversEvent>((event, emit) {
      globals.reversMap = !globals.reversMap;
      developer.log('Event - PressButtonHelpEvent');
      emit(AppState(
        counter: state.counter,
        buttomPressed: state.buttomPressed,
        buttonHelpPressed: state.buttonHelpPressed,
        buttonChoise: state.buttonChoise,
        buttonReverse: globals.reversMap,
        soundOn: globals.soundOn,
        wrong: state.wrong,
        good: state.good,
        target: state.target,
        page: state.page,
        truePosition: state.truePosition,
        listButton: state.listButton,
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
        buttonReverse: state.buttonReverse,
      ));
    });
  }
}
