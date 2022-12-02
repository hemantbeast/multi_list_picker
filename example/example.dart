import 'package:flutter/material.dart';
import 'package:multi_list_picker/models/multi_list_model.dart';
import 'package:multi_list_picker/multi_list_picker.dart';

import 'model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = '';
  final lstData = <MultiListModel>[];

  @override
  void initState() {
    super.initState();
    lstData
      ..add(MultiListModel(item: ItemModel(index: 0, name: 'Item 1')))
      ..add(MultiListModel(item: ItemModel(index: 1, name: 'Item 2')))
      ..add(MultiListModel(item: ItemModel(index: 2, name: 'Item 3')))
      ..add(MultiListModel(item: ItemModel(index: 3, name: 'Item 4')))
      ..add(MultiListModel(item: ItemModel(index: 4, name: 'Item 5')))
      ..add(MultiListModel(item: ItemModel(index: 5, name: 'Item 6')))
      ..add(MultiListModel(item: ItemModel(index: 6, name: 'Item 7')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi list picker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                var height = 200.0;
                if (lstData.length < 5) {
                  height = lstData.length * 50;
                }

                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return MultiListPicker(
                      title: 'Select Item',
                      items: lstData,
                      height: height,
                      displayPropertyName: 'name',
                      titleStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      itemTextStyle: const TextStyle(
                        color: Colors.black38,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      buttonStyle: ElevatedButton.styleFrom(
                        elevation: 1,
                        minimumSize: const Size(80, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      closeIcon: const Icon(Icons.close, size: 24),
                      onSelected: (list) {
                        setState(() {
                          text = 'Selected values\n';
                          for (var i = 0; i < list.length; i++) {
                            var item = list[i] as ItemModel;
                            text += '${item.name}\n';
                          }
                        });
                      },
                    );
                  },
                );
              },
              child: const Text('Open picker'),
            ),
          ),
          const SizedBox(height: 30),
          Visibility(
            visible: text.isNotEmpty,
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black26,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
