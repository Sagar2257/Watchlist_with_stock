import 'package:flutter_bloc/flutter_bloc.dart';
import '../Instrument.dart';
import 'WatchlistEvent.dart';
import 'WatchlistState.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc()
      : super(const WatchlistState(watchlists: [], selectedIndex: 0)) {

    /// 🔹 LOAD WATCHLISTS
    on<LoadWatchlists>((event, emit) {
      emit(
        WatchlistState(
          selectedIndex: 0,
          watchlists: [
            [
              Instrument(name: "RELIANCE", ltp: 1374.10, change: -4.40),
              Instrument(name: "HDFCBANK", ltp: 966.95, change: 0.95),
              Instrument(name: "ASIANPAINT", ltp: 2537.40, change: 6.60),
              Instrument(name: "NIFTY IT", ltp: 35184.30, change: 873.86),
              Instrument(name: "HDFCBANK", ltp: 966.95, change: 0.95),
              Instrument(name: "Tata", ltp: 2537.40, change: 6.60),
              Instrument(name: "PNB Bank", ltp: 35184.30, change: 873.86),
            ],
            [
              Instrument(name: "INFY", ltp: 1500, change: 1.5),
              Instrument(name: "TCS", ltp: 3500, change: -2),
              Instrument(name: "Tata Steal", ltp: 1500, change: 1.5),
              Instrument(name: "Adani Power", ltp: 3500, change: -2),
              Instrument(name: "Jindal Steal", ltp: 1500, change: 1.5),
              Instrument(name: "Raymond", ltp: 3500, change: -2),
            ],
          ],
        ),
      );
    });

    /// 🔹 SWITCH WATCHLIST TAB
    on<SwitchWatchlist>((event, emit) {
      if (event.index >= 0 &&
          event.index < state.watchlists.length) {
        emit(state.copyWith(selectedIndex: event.index));
      }
    });

    /// 🔹 REORDER ITEMS
    on<ReorderWatchlist>((event, emit) {
      if (state.watchlists.isEmpty) return;

      final lists = List<List<Instrument>>.from(state.watchlists);

      if (state.selectedIndex >= lists.length) return;

      final current = List<Instrument>.from(
        lists[state.selectedIndex],
      );

      if (event.oldIndex >= current.length) return;

      int newIndex = event.newIndex;
      if (newIndex > event.oldIndex) newIndex--;

      final item = current.removeAt(event.oldIndex);
      current.insert(newIndex, item);

      lists[state.selectedIndex] = current;

      emit(state.copyWith(watchlists: lists));
    });

    /// 🔹 DELETE ITEM
    on<DeleteInstrument>((event, emit) {
      if (state.watchlists.isEmpty) return;

      final lists = List<List<Instrument>>.from(state.watchlists);

      if (state.selectedIndex >= lists.length) return;

      final current = List<Instrument>.from(
        lists[state.selectedIndex],
      );

      if (event.index < current.length) {
        current.removeAt(event.index);
      }

      lists[state.selectedIndex] = current;

      emit(state.copyWith(watchlists: lists));
    });

    /// 🔹 SAVE EDITED WATCHLIST (FROM EDIT SCREEN)
    on<SaveWatchlist>((event, emit) {
      if (state.watchlists.isEmpty) return;

      final lists = List<List<Instrument>>.from(state.watchlists);

      if (state.selectedIndex >= lists.length) return;

      lists[state.selectedIndex] = List<Instrument>.from(event.updatedList);

      emit(state.copyWith(watchlists: lists));
    });
  }
}