part of 'bloc.dart';

abstract class AppBlocEvent {
  const AppBlocEvent();
}

class PressButtonChoiseEvent extends AppBlocEvent {
  final bool answer;
  PressButtonChoiseEvent(this.answer);
}
