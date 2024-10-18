import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google/Provider/Browser.dart';
import 'package:google/main.dart';
import 'package:provider/provider.dart';

late InAppWebViewController? _webViewController;

RxString search = ''.obs;
String data = '';

PullToRefreshController pullToRefreshController = PullToRefreshController(
  onRefresh: () {
    _webViewController?.reload();
  },
);

void handleClick(String value) {
  switch (value) {
    case 'All BookMark':
      break;
    case 'Search Engine':
      break;
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    GoogleController controller1 = Provider.of<GoogleController>(context);
    return SafeArea(
      child: Scaffold(
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BottomSheet(
            shape: Border(),
            onClosing: () {},
            builder: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  LinearProgressIndicator(
                    // value: controller.value,
                    // value: 15,
                    semanticsLabel: 'Linear progress indicator',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            InAppWebView(
                              initialUrlRequest: URLRequest(
                                  url: WebUri("https://www.google.com")),
                              onWebViewCreated:
                                  (InAppWebViewController controller) {
                                _webViewController = controller;
                              },
                            );
                          },
                          child: Icon(
                            Icons.home,
                            size: 25,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Fluttertoast.showToast(
                                msg: "Save Data Successfully !!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                          child: Icon(
                            Icons.bookmark_add_outlined,
                            size: 25,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await _webViewController?.goBack();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_outlined,
                            size: 25,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await _webViewController?.reload();
                          },
                          child: Icon(
                            Icons.restart_alt_rounded,
                            size: 25,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await _webViewController?.goForward();
                          },

                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xfff4f4f4),
        appBar: AppBar(
          title: SizedBox(
            height: 40,
            child: TextField(
              controller: controller1.txtSearch,
              onSubmitted: (value) {
                _webViewController?.loadUrl(
                  urlRequest: URLRequest(
                    url: WebUri(
                        "https://www.${controller1.m1}.com/search?q=$value"),
                  ),
                );
                // String data = txtSearch.text;
                // search = data.obs;
                data = controller1.txtSearch.text;
                // controller1.searchData(data);
                controller1.setList(data);
                print('-------------------------------->');
              },
              decoration: InputDecoration(
                // fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                // fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search here..",
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ),

          // centerTitle: true,
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog.fullscreen(
                          child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'All Save Data',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          (controller1.dataStore.length == 0)
                              ? Text('No Data Save ')
                              : Column(
                                  children: [
                                    ...List.generate(
                                      controller1.dataStore.length,
                                      (index) => Column(
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              data =
                                                  controller1.dataStore[index];
                                              Navigator.of(context).pop();
                                              // });
                                              _webViewController?.loadUrl(
                                                urlRequest: URLRequest(
                                                  url: WebUri(
                                                      "https://www.${controller1.m1}.com/search?q=$data"),
                                                ),
                                              );
                                            },
                                            title: Text(
                                              controller1.dataStore[index],
                                            ),
                                            trailing: InkWell(
                                                onTap: () {
                                                  controller1.dataStore
                                                      .removeAt(index);
                                                },
                                                child: Icon(Icons.close)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      )),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.bookmark),
                      Text('All Book Mark'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    // setState(() {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Search Engin'),
                        actions: [
                          RadioListTile(
                              title: const Text('Google'),
                              value: 'Google',
                              groupValue: controller1.m1,
                              onChanged: (value) {
                                _webViewController?.loadUrl(
                                  urlRequest: URLRequest(
                                    url: WebUri(
                                        "https://www.${controller1.m1}.com/search?q=$data"),
                                  ),
                                );
                                controller1.m1 =
                                    value!; // Update the group value
                                print(value);
                                // setState(() {
                                // controller1.searchengine(value!,data);
                                Navigator.of(context).pop();
                                // });
                              }),
                          RadioListTile(
                            title: const Text('Yahoo'),
                            value: 'Yahoo',
                            groupValue: controller1.m1,
                            onChanged: (value) {
                              _webViewController?.loadUrl(
                                urlRequest: URLRequest(
                                  url: WebUri(
                                      "https://www.${controller1.m1}.com/search?q=$data"),
                                ),
                              );
                              controller1.m1 = value!; // Update the group value
                              print(value);
                              // setState(() {
                              // controller1.searchengine(value!,data);
                              Navigator.of(context).pop();

                              // });
                            },
                          ),
                          RadioListTile(
                            title: const Text('Bing'),
                            value: 'Bing',
                            groupValue: controller1.m1,
                            onChanged: (value) {
                              _webViewController?.loadUrl(
                                urlRequest: URLRequest(
                                  url: WebUri(
                                      "https://www.${controller1.m1}.com/search?q=$data"),
                                ),
                              );
                              controller1.m1 = value!; // Update the group value
                              print(value);
                              // setState(() {
                              // controller1.searchengine(value!,data);
                              Navigator.of(context).pop();

                              // });
                            },
                          ),
                          RadioListTile(
                            title: const Text('Duck Duck Go'),
                            value: 'DuckDuckGO',
                            groupValue: controller1.m1,
                            onChanged: (value) {
                              _webViewController?.loadUrl(
                                urlRequest: URLRequest(
                                  url: WebUri(
                                      "https://www.${controller1.m1}.com/search?q=$data"),
                                ),
                              );
                              controller1.m1 = value!; // Update the group value
                              print(value);
                              // controller1.searchengine(value!,data);
                              Navigator.of(context).pop();

                              // });
                            },
                          ),
                        ],
                      ),
                    );
                    // });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.content_paste_search_rounded),
                      Text('Search Engine')
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            if (snapshot.data!.contains(ConnectivityResult.mobile) ||
                snapshot.data!.contains(ConnectivityResult.wifi)) {
              return InAppWebView(
                initialUrlRequest:
                    URLRequest(url: WebUri("https://www.google.com")),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
              );
            } else {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      "No Internet connection",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      height: 300,
                      child: Image.asset(
                        'assets/img/repeat-jump.gif',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      "Please Check your connection \n   again, or connect to wifi.",
                      style: TextStyle(fontSize: 23, color: Color(0xff7294a6)),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          color: const Color(0xff143f61),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                        'REFRESH',
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 5,
                            fontSize: 17),
                      )),
                    )
                    // const CircularProgressIndicator(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

