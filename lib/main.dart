import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _menus = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('lib/content/data.json');
    final data = await json.decode(response);
    setState(() {
      _menus = data["menus"];
    });
  }

  void initState() {
    super.initState();
    readJson();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 40.0,
        color: Colors.redAccent,
        child: _menus.length > 0
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _menus.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: PopupMenuButton<int>(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              IconData(_menus[index]["leading_icon"],
                                  fontFamily: 'MaterialIcons'),
                              color: Colors.white,
                            ),
                            Text(
                              _menus[index]["name"],
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Text(
                            "Flutter Open",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Text(
                            "Flutter Tutorial",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                      offset: Offset(0, 32),
                    ),
                  );
                },
              )
            : Container(),
      ),
    );
  }
}
