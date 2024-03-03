import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier {
  int _rows = 1;
  int _columns = 1;
  int _alphabetsCount = 1;

  // bool _enterAlphabetsVisible = false;

  String _userAlphabets = "";
  String _searchAlphabets = "";
  List<String> _userAlphabetsList = [];
  List<String> _foundAlphabets = [];
  List<Widget> _gridItems = [];
  List<int> _matchedRows = [];
  List<int> _matchedColumns = [];
  List<int> _matchedDiagonal = [];

  int get rows => _rows;

  int get columns => _columns;

  int get alphabetsCount => _alphabetsCount;

  // bool get enterAlphabetsVisible => _enterAlphabetsVisible;

  String get userAlphabets => _userAlphabets;

  String get searchAlphabets => _searchAlphabets;

  List<Widget> get gridItems => _gridItems;

  List<String> get userAlphabetsList => _userAlphabetsList;

  List<String> get foundAlphabets => _foundAlphabets;

  List<int> get matchedRows => _matchedRows;

  List<int> get matchedColumns => _matchedColumns;

  List<int> get matchedDiagonal => _matchedDiagonal;

  updateRows(int myRows) {
    _rows = myRows;
    updateAlphabetsCount();
    notifyListeners();
  }

  updateColumns(int myColumns) {
    _columns = myColumns;
    updateAlphabetsCount();
    notifyListeners();
  }

  updateUserAlphabets(String myUserAlphabets) {
    _userAlphabets = myUserAlphabets;
    callGenerateGridItems();
    notifyListeners();
  }

  searchUserAlphabets(String searchUserAlphabets) {
    _searchAlphabets = searchUserAlphabets;
    checkMatch();
    // callGenerateGridItems();
    notifyListeners();
  }

  callGenerateGridItems() {
    if (_rows > 0 && _columns > 0) {
      _userAlphabetsList = _userAlphabets.split("");
      _gridItems = generateGridItems();
      notifyListeners();
    } else {
      const Text('Invalid Number of rows and columns');
      notifyListeners();
    }
  }

  updateAlphabetsCount() {
    _alphabetsCount = _rows * _columns;
    notifyListeners();
  }

  /*List<Widget> generateGridItems() {
    print("Grid getting Generated");
    List<Widget> items = [];

    for (int i = 0; i < _rows; i++) {
      for (int j = 0; j < _columns; j++) {
        int number = i * _columns + j;
        // int number = i * columns + j + 1;
        // 0,1,2
        // 3,4,5
        // 6,7,8
        items.add(
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: matchedRows.contains(number)
                  ? Colors.black12
                  : Colors.blue,
              // color: Colors.black12,
            ),
            */ /*
            if(
            */ /*
            alignment: Alignment.center,
            child: Text(_userAlphabetsList[number]),
          ),
        );
      }
    }
    return items;
  }*/

  List<Widget> generateGridItems() {
    _gridItems.clear();
    List<Widget> items = [];
    print("Grid getting Generated");

    for (int i = 0; i < _rows; i++) {
      for (int j = 0; j < _columns; j++) {
        int number = i * _columns + j;
        // int number = i * columns + j + 1;
        // 0,1,2
        // 3,4,5
        // 6,7,8
        items.add(
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: (_matchedRows.contains(number) ||
                      _matchedColumns.contains(number) ||
                      _matchedDiagonal.contains(number)
                  ? Colors.blue
                  : Colors.black12),
              // color: Colors.black12,
            ),
            /*
            if(
            */
            alignment: Alignment.center,
            child: Text(_userAlphabetsList[number]),
          ),
        );
      }
    }
    return items;
  }

  checkMatch() {
    _matchedRows.clear();
    _matchedColumns.clear();
    _matchedDiagonal.clear();
    //Horizontal
    int count = 0;

    List<String> tempRow = [];
    List<List<String>> rowsList = [];
    for (int i = 0; i < _userAlphabetsList.length; i++) {
      List<String> myRow = [];
      // print("RowsList before loop $rowsList");
      // print("MyRow before loop $myRow");
      count = count + 1;
      tempRow.add(_userAlphabetsList[i]);
      // print("Temp Row $tempRow");
      if (count == _userAlphabetsList.length ~/ _columns) {
        // print("Inside Count == userAlphabets");
        // print("Count $count");
        // print("tempRows ${tempRow[i - 2]},${tempRow[i - 1]},${tempRow[i]}");
        myRow.clear();
        for (int j = count - 1; j >= 0; j--) {
          // print("I value $i");
          // print("J value $j");
          /*
          j=4,3
          temp[4-4],temp[4-3],temp[4-2],temp[4-1],temp[4-0]
          * */
          myRow.add(tempRow[i - j]);
          // print("MyRow $myRow");
        }
        rowsList.add(myRow);
        // tempRow.clear();
        count = 0;
        print("RowsList $rowsList");
      }
    }
    for (int i = 0; i < _rows; i++) {
      String rowString = rowsList[i].join();
      if (rowString.contains(_searchAlphabets) &&
          _searchAlphabets != "" &&
          _searchAlphabets.split("").length == _rows) {
        for (int j = 0; j < rowsList[i].length; j++) {
          int number = i * rowsList[i].length + j;
          _matchedRows.add(number);
        }
        print("Matched Rows $_matchedRows");
        //if 0,2 is true then return matchedRows[0] = myRow[0] = [m,a,d]= [0,1,2],matchedRows[2] = myRow[2] =[m,a,d] = [6,7,8]
      }
    }

    //Vertical
    List<List> columnsList = [];
    for (int j = 0; j < _columns; j++) {
      List myColumns = [];
      for (int i = 0; i < rowsList.length; i++) {
        myColumns.add(rowsList[i][j]);
      }
      columnsList.add(myColumns);
    }

    for (int j = 0; j < _columns; j++) {
      String columnString = columnsList[j].join();
      if (columnString.contains(_searchAlphabets) &&
          _searchAlphabets != "" &&
          _searchAlphabets.split("").length == _columns) {
        for (int i = 0; i < columnsList[j].length; i++) {
          int number = i * _columns + j;
          _matchedColumns.add(number);
        }
        print("Matched Columns $_matchedColumns");
      }
    }

    //Diagonal
    if (_searchAlphabets.length == _rows &&
        _searchAlphabets.length == _columns &&
        _searchAlphabets != "" &&
        _searchAlphabets.split("").length == _columns) {
      for (int i = 0; i < _searchAlphabets.length; i++) {
        int index = i * (_columns + 1);
        if (_userAlphabetsList[index] == _searchAlphabets[i]) {
          _matchedDiagonal.add(index);
        }
      }
    }
    print("Match Diagonal $matchedDiagonal");

    callGenerateGridItems();
    notifyListeners();
  }
}
