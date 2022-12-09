import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Choise extends Equatable {
  int page = 0;
  int target = 0;
  int truePosition = 0;
  List<int> listButton = [];

  Choise({
    required this.page,
    required this.target,
    required this.truePosition,
    required this.listButton,
  });

  @override
  List<Object?> get props => [target];
}
