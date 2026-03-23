import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Instrument.dart';
import '../bloc/WatchlistBloc.dart';
import '../bloc/WatchlistEvent.dart';

class EditWatchlistScreen extends StatefulWidget {
  @override
  State<EditWatchlistScreen> createState() => _EditWatchlistScreenState();
}

class _EditWatchlistScreenState extends State<EditWatchlistScreen> {

  late List<Instrument> tempList;

  @override
  void initState() {
    super.initState();

    final state = context.read<WatchlistBloc>().state;

    tempList = (state.watchlists.isNotEmpty &&
        state.selectedIndex < state.watchlists.length)
        ? List<Instrument>.from(
      state.watchlists[state.selectedIndex],
    )
        : [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        title: Text("Edit Watchlist 1"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Column(
        children: [

          // 🔹 Header Box
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Watchlist"),
                  Icon(Icons.edit),
                ],
              ),
            ),
          ),

          // 🔹 List
          Expanded(
            child: ReorderableListView.builder(
              itemCount: tempList.length,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex--;

                  final item = tempList.removeAt(oldIndex);
                  tempList.insert(newIndex, item);
                });
              },
              itemBuilder: (context, index) {
                final item = tempList[index];

                return Container(
                  key: ValueKey(item.name),
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.drag_handle),

                    title: Text(
                      item.name,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),

                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          tempList.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          // 🔻 Bottom Section
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [

                // Edit other watchlists
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Edit other watchlists",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),

                SizedBox(height: 12),

                // Save Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    context.read<WatchlistBloc>().add(
                      SaveWatchlist(tempList),
                    );

                    Navigator.pop(context);
                  },
                  child: Text(
                    "Save Watchlist",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}