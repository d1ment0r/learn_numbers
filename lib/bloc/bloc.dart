import 'package:bloc/bloc.dart';
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
          truePosition: 0,
        )) {
    on<PressButtonChoiseEvent>((event, emit) {
      try {
        state.counter++;
        state.buttomPressed = true;
        if (event.answer) {
          state.good++;
        } else {
          state.wrong++;
        }
        emit(AppState.update(
          page: state.page,
          counter: state.counter,
          wrong: state.wrong,
          good: state.good,
          buttomPressed: false,
          target: state.target,
          truePosition: state.truePosition,
          buttonHelpPressed: true,
        ));
      } on Exception catch (e) {
        // ignore: avoid_print
        print(e);
      }
    });
    on<PressButtonHelpEvent>((event, emit) {
      state.buttonHelpPressed = true;
      emit(AppState(
          counter: state.counter,
          buttomPressed: false,
          buttonHelpPressed: true,
          wrong: state.wrong,
          good: state.good,
          target: state.target,
          page: state.page,
          truePosition: state.truePosition,
          textButton: state.textButton));
    });
  }
}
