import 'package:flutter/material.dart';
import 'package:mobigic_app/providers/home_screen_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rowsController = TextEditingController();
    final columnsController = TextEditingController();
    final userAlphabetsController = TextEditingController();
    final userSearchAlphabetsController = TextEditingController();

    return Consumer<HomeScreenProvider>(
      builder: (context, homeScreenProvider, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Fill below Fields',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: TextField(
                        onChanged: (rowsChanged) {
                          homeScreenProvider.updateRows(int.tryParse(rowsChanged) ?? 1);
                        },
                        keyboardType: TextInputType.number,
                        controller: rowsController,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Rows',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: TextField(
                        onChanged: (columnsChanged) => homeScreenProvider.updateColumns(int.tryParse(columnsChanged) ?? 1),
                        keyboardType: TextInputType.number,
                        controller: columnsController,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Columns',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                //Generate Grid Button
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: TextField(
                        controller: userAlphabetsController,
                        maxLength: homeScreenProvider.alphabetsCount,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        onChanged: (textChanged) =>
                            homeScreenProvider.updateUserAlphabets(textChanged),
                        decoration: const InputDecoration(
                          labelText: 'Enter Alphabets',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: TextField(
                        controller: userSearchAlphabetsController,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        onChanged: (searchText) {
                          homeScreenProvider.searchUserAlphabets(searchText);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Search Alphabets',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                ElevatedButton(
                  onPressed: () {
                    homeScreenProvider.searchUserAlphabets(userSearchAlphabetsController.text);
                    // homeScreenProvider.callGenerateGridItems();
                    // homeScreenProvider.matchedRows.clear();
                  },
                  child: const Text('Search Text'),
                ),
                const SizedBox(height: 10,),

                Expanded(
                  child: GridView.count(
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    crossAxisCount:
                        (int.tryParse(columnsController.text) ?? 0) > 0
                            ? int.tryParse(columnsController.text) ?? 0
                            : 1,
                    children: homeScreenProvider.gridItems,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
