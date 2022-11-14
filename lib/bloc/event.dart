part of 'bloc.dart';

abstract class AppEvent {
  // const AppBlocEvent();
}

class PressButtonChoiseEvent extends AppEvent {
  final int choise;
  PressButtonChoiseEvent(this.choise);
}

class PressButtonHelpEvent extends AppEvent {
  final int currentTarget;
  PressButtonHelpEvent(this.currentTarget);
}

class UpdateScreenEvent extends AppEvent {
  UpdateScreenEvent();
}
