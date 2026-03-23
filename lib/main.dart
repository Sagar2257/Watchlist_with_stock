import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_watchlist/screen/WatchlistScreen.dart';


import 'bloc/WatchlistBloc.dart';
import 'bloc/WatchlistEvent.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WatchlistBloc()..add(LoadWatchlists()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WatchlistScreen(),
      ),
    );
  }
}