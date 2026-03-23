import 'package:equatable/equatable.dart';
import '../Instrument.dart';


class WatchlistState extends Equatable {
  final List<List<Instrument>> watchlists;
  final int selectedIndex;

  const WatchlistState({
    required this.watchlists,
    required this.selectedIndex,
  });

  WatchlistState copyWith({
    List<List<Instrument>>? watchlists,
    int? selectedIndex,
  }) {
    return WatchlistState(
      watchlists: watchlists ?? this.watchlists,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [watchlists, selectedIndex];
}