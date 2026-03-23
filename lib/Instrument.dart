import 'package:equatable/equatable.dart';

class Instrument extends Equatable {
  final String name;
  final double ltp;
  final double change;

  const Instrument({
    required this.name,
    required this.ltp,
    required this.change,
  });

  Instrument copyWith({
    double? ltp,
    double? change,
  }) {
    return Instrument(
      name: name,
      ltp: ltp ?? this.ltp,
      change: change ?? this.change,
    );
  }

  @override
  List<Object?> get props => [name, ltp, change];
}