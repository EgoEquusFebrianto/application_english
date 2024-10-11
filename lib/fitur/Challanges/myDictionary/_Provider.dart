import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class WordProvider with ChangeNotifier {
  String? selector;
  List<dynamic> elementDict = [];
  String sortingType = 'id_asc';
  WordProvider() {
    _loadingData();
  }

  Future<void> _loadingData() async {
    try {
      String data = await rootBundle.loadString('assets/dictionary.json');
      elementDict = jsonDecode(data);
      _sortData();
    } catch (e) {
      print('Error Loading Json: $e');
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> get words => List<Map<String, dynamic>>.from(elementDict);

  List<Map<String, dynamic>> getWordsByTab(String tab) {
    return words.where((word) => word['TabsBar'] == tab).toList();
  }

  void toggleExpanded(String id) {
    if (selector == id) {
      selector = null;
    } else {
      selector = id;
    }
    notifyListeners();
  }

  void setSortingType(String type) {
    sortingType = type;
    _sortData();
    notifyListeners();
  }

  void _sortData() {
    switch (sortingType) {
      case 'id_asc':
        elementDict.sort((a, b) => int.parse(a['id']).compareTo(int.parse(b['id'])));
        break;
      case 'word_asc':
        elementDict.sort((a, b) => a['word'].compareTo(b['word']));
        break;
      case 'word_desc':
        elementDict.sort((a, b) => b['word'].compareTo(a['word']));
        break;
    }
  }
}
