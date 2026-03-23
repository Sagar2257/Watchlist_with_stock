import 'package:equatable/equatable.dart';

import '../Instrument.dart';

abstract class WatchlistEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadWatchlists extends WatchlistEvent {}

class SwitchWatchlist extends WatchlistEvent {
  final int index;
  SwitchWatchlist(this.index);

  @override
  List<Object?> get props => [index];
}

class ReorderWatchlist extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;

  ReorderWatchlist(this.oldIndex, this.newIndex);

  @override
  List<Object?> get props => [oldIndex, newIndex];
}
class DeleteInstrument extends WatchlistEvent {
  final int index;
  DeleteInstrument(this.index);
}

class SaveWatchlist extends WatchlistEvent {
  final List<Instrument> updatedList;
  SaveWatchlist(this.updatedList);
}