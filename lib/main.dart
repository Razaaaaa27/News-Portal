import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'home.dart';
import 'kategori.dart';
import 'profil.dart';

void main() {
  runApp(MyApp(initialPage: 0));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.initialPage}) : super(key: key);
  final int initialPage;
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _page = 0;
  final _pageOption = [KategoriPage(), HomePage(), ProfilPage()];
  
  @override
  void initState() {
    super.initState();
    setState(() {
      _page = widget.initialPage;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portal News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SafeArea(
        child: Scaffold(
          body: _pageOption[_page],
          bottomNavigationBar: CurvedNavigationBar(
            height: 50.0,
            color: Colors.blue,
            backgroundColor: Colors.white,
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
            items: <Widget>[
              Icon(Icons.category, color: Colors.white),
              Icon(Icons.home, color: Colors.white),
              Icon(Icons.account_circle, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}