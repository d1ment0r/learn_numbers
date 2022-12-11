import 'package:equatable/equatable.dart';
import 'package:learn_numbers/models/globals.dart' as globals;

// ignore: must_be_immutable
class Translate extends Equatable {
  const Translate();

  @override
  List<Object?> get props => throw UnimplementedError();

  getByNumer({int? number}) {
    return globals.sortingMap[number ?? 0];
  }
}
