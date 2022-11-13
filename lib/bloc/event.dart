part of 'bloc.dart';

abstract class AppEvent {
  // const AppBlocEvent();
}

class PressButtonChoiseEvent extends AppEvent {
  final bool answer;
  PressButtonChoiseEvent(this.answer);
}

class PressButtonHelpEvent extends AppEvent {
  final int currentTarget;
  PressButtonHelpEvent(this.currentTarget);
}
