import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';

// late InAppWebViewController? _webViewController;

class GoogleController extends ChangeNotifier {
  TextEditingController txtSearch = TextEditingController();
  String m1 = 'Google';
  int variable = 0;
  int number = 0;

  List<String> dataStore = [];

  // void searchengine(String value,String data) {
  //   // _webViewController?.loadUrl(
  //     urlRequest: URLRequest(
  //       url: WebUri(
  //           "https://www.${m1}.com/search?q=$data"),
  //     // ),
  //   );
  //   m1 = value!; // Update the group value
  //   print(value);
  //   notifyListeners();
  // }

  void searchData(String data) {
    dataStore.add(data.toString());
    print(
        '------------------------------------------------------------------------------------------------------------------------------------------\n------------------------------------------------------------------------------------->');
    print(dataStore);
    txtSearch.clear();
    notifyListeners();
  }

  Future<void> setList(String data) async {
    dataStore.add(data.toString());
    print(
        '------------------------------------------------------------------------------------------------------------------------------------------\n------------------------------------------------------------------------------------->');
    print(dataStore);
    txtSearch.clear();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('items', dataStore);
    notifyListeners();
  }

  // Future<void>? refreshWeb(SearchProvider searchProviderTrue) {
  //   return webViewController?.loadUrl(
  //     urlRequest: URLRequest(
  //       url: WebUri(searchProviderTrue.setSearchEngine),
  //     ),
  //   );
  // }

  String saveList(int index, String data) {
    data = dataStore[index];
    print('---------------------------------------->');
    print(data);
    notifyListeners();
    return data;
  }

  Future<void> getList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    dataStore = sharedPreferences.getStringList('items') ?? [];
    notifyListeners();
  }

  Future<void> removeFromSaved(int index) async {
    dataStore.removeAt(index);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('items', dataStore);
    notifyListeners();
  }
}
