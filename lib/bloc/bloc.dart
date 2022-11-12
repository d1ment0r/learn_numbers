import 'dart:io';

import 'package:bloc/bloc.dart';
import 'state.dart';
part 'event.dart';

class AppBlocBloc extends Bloc<AppBlocEvent, AppState> {
  int counter;
  int wrong;
  int good;

  final int page;
  final int target;
  final int truePosition;
  late bool buttomPressed;
  final List<String> textButton;

  AppBlocBloc({
    required this.page,
    required this.target,
    required this.truePosition,
    required this.buttomPressed,
    required this.textButton,
    required this.counter,
    required this.wrong,
    required this.good,
  }) : super(AppState.empty(
            page: page,
            target: target,
            truePosition: truePosition,
            textButton: textButton)) {
    on<PressButtonChoiseEvent>((event, emit) {
      try {
        counter++;
        buttomPressed = true;
        print('Answer - ${event.answer} truePosition $truePosition');
        if (event.answer) {
          good++;
        } else {
          wrong++;
        }
        // emit(AppState(
        //     counter: counter,
        //     wrong: wrong,
        //     good: good,
        //     target: target,
        //     buttomPressed: buttomPressed,
        //     page: page,
        //     truePosition: truePosition,
        //     textButton: textButton));
        // emit(AppState.asincPause());
        emit(AppState.update(
            counter: counter,
            wrong: wrong,
            good: good,
            buttomPressed: false,
            target: target,
            page: page,
            truePosition: truePosition,
            textButton: textButton));
      } on Exception catch (e) {
        // ignore: avoid_print
        print(e);
      }
    });
  }
}
