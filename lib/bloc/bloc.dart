import 'dart:developer' as console;
import 'package:learn_numbers/models/globals.dart' as globals;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'state.dart';
part 'event.dart';

class AppBlocBloc extends Bloc<AppEvent, AppState> {
  int page;

  AppBlocBloc({
    required this.page,
  }) : super(
          AppState.init(
            page: page,
          ),
        ) {
    on<PressButtonChoiseEvent>((event, emit) {
      console.log(
          '\u001b[1;33mBloc: \u001b[0mevent \u001b[1;34mPressButtonChoiseEvent');
      globals.counter++;
      state.buttomPressed = true;
      state.buttonChoise = event.choise;
      if (event.choise == state.truePosition) {
        globals.good++;
      } else {
        globals.wrong++;
      }
      emit(AppState(
        buttomPressed: true,
        buttonHelpPressed: true,
        buttonChoise: state.buttonChoise,
        buttonReverse: globals.reversMap,
        soundOn: globals.soundOn,
        target: state.target,
        page: state.page,
        truePosition: state.truePosition,
        listButton: state.listButton,
      ));
    });

    on<PressButtonHelpEvent>((event, emit) {
      state.buttonHelpPressed = true;
      console.log(
          '\u001b[1;33mBloc: \u001b[0mevent \u001b[1;34mPressButtonHelpEvent');
      emit(AppState.speech(
        buttomPressed: false,
        buttonHelpPressed: true,
        buttonChoise: state.buttonChoise,
        buttonReverse: state.buttonReverse,
        soundOn: globals.soundOn,
        target: state.target,
        page: state.page,
        truePosition: state.truePosition,
        listButton: state.listButton,
      ));
    });

    on<ChangeSoundStateEvent>((event, emit) {
      if (globals.soundOn) {
        console.log(
            '\u001b[1;33mBloc: \u001b[0mevent \u001b[1;34mChangeSoundStateEvent, sound: on');
      } else {
        console.log(
            '\u001b[1;33mBloc: \u001b[0mevent \u001b[1;34mChangeSoundStateEvent, sound: off');
      }
      emit(AppState.speech(
        buttomPressed: state.buttomPressed,
        buttonHelpPressed: state.buttonHelpPressed,
        buttonChoise: state.buttonChoise,
        buttonReverse: state.buttonReverse,
        soundOn: globals.soundOn,
        target: state.target,
        page: state.page,
        truePosition: state.truePosition,
        listButton: state.listButton,
      ));
    });

    on<PressButtonReversEvent>((event, emit) {
      globals.reversMap = !globals.reversMap;
      console.log(
          '\u001b[1;33mBloc: \u001b[0mevent \u001b[1;34mPressButtonHelpEvent');
      emit(AppState(
        buttomPressed: state.buttomPressed,
        buttonHelpPressed: state.buttonHelpPressed,
        buttonChoise: state.buttonChoise,
        buttonReverse: globals.reversMap,
        soundOn: globals.soundOn,
        target: state.target,
        page: state.page,
        truePosition: state.truePosition,
        listButton: state.listButton,
      ));
    });

    on<UpdateScreenEvent>((event, emit) {
      state.buttomPressed = false;
      console.log(
          '\u001b[1;33mBloc: \u001b[0mevent \u001b[1;34mUpdateScreenEvent');
      emit(AppState.update(
        buttomPressed: false,
        buttonHelpPressed: false,
        target: state.target,
        page: state.page,
        truePosition: state.truePosition,
      ));
    });
  }
}
