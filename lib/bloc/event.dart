part of 'bloc.dart';

abstract class AppEvent {}

class PressButtonChoiseEvent extends AppEvent {
  final int choise;
  PressButtonChoiseEvent(this.choise);
}

class PressButtonHelpEvent extends AppEvent {
  PressButtonHelpEvent();
}

class UpdateScreenEvent extends AppEvent {
  UpdateScreenEvent();
}

class PressButtonReversEvent extends AppEvent {
  PressButtonReversEvent();
}

class ChangeSoundStateEvent extends AppEvent {
  ChangeSoundStateEvent();
}
