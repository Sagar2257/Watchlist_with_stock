import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/WatchlistBloc.dart';
import '../bloc/WatchlistEvent.dart';
import '../bloc/WatchlistState.dart';
import 'EditWatchlistScreen.dart';



class WatchlistScreen extends StatefulWidget {
  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {

  @override
  void initState() {
    super.initState();
    context.read<WatchlistBloc>().add(LoadWatchlists());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔻 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Watchlist"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.flash_on), label: "GTT+"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Portfolio"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Profile"),
        ],

      ),

      body: SafeArea(
        child: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {

            final list = state.watchlists.isEmpty
                ? []
                : state.watchlists[state.selectedIndex];

            return Column(
              children: [

                // 🔥 Top Market Section
                _buildMarketHeader(),

                // 🔍 Search Bar
                _buildSearchBar(),

                // 📊 Tabs
                _buildTabs(state),

                // 🔽 Sort Button
                _buildSortButton(),

                // 📈 List
                Expanded(
                  child: ReorderableListView.builder(
                    itemCount: list.length,
                    onReorder: (oldIndex, newIndex) {
                      context.read<WatchlistBloc>().add(
                        ReorderWatchlist(oldIndex, newIndex),
                      );
                    },
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return _buildRow(item, index);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // 🔥 MARKET HEADER
  Widget _buildMarketHeader() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _marketBox("SENSEX", "1,225.55", "+144.50", true),
          _marketBox("NIFTY BANK", "54,172.15", "-14.75", false),
        ],
      ),
    );
  }

  Widget _marketBox(String title, String price, String change, bool isUp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Text(price),
            SizedBox(width: 5),
            Text(
              change,
              style: TextStyle(color: isUp ? Colors.green : Colors.red),
            )
          ],
        )
      ],
    );
  }

  // 🔍 SEARCH
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search for instruments",
          prefixIcon: Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  // 📊 TABS
  Widget _buildTabs(WatchlistState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(state.watchlists.length, (index) {
        return GestureDetector(
          onTap: () {
            context.read<WatchlistBloc>().add(SwitchWatchlist(index));
          },
          child: Column(
            children: [
              Text(
                "Watchlist ${index + 1}",
                style: TextStyle(
                  fontWeight: state.selectedIndex == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              if (state.selectedIndex == index)
                Container(height: 2, width: 50, color: Colors.black)
            ],
          ),
        );
      }),
    );
  }

  // 🔽 SORT BUTTON
  Widget _buildSortButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditWatchlistScreen(),
                ),
              );
            },
          icon: Icon(Icons.sort),
          label: Text("Sort by"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade300,
            foregroundColor: Colors.black,
          ),
        ),
      ),
    );
  }

  // 📈 LIST ROW
  Widget _buildRow(item, index) {
    return ListTile(
      key: ValueKey(item.name),
      title: Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("NSE | EQ"),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            item.ltp.toStringAsFixed(2),
            style: TextStyle(
              color: item.change >= 0 ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            item.change.toStringAsFixed(2),
            style: TextStyle(
              color: item.change >= 0 ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}