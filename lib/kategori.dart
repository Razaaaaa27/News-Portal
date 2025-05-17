import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class KategoriPage extends StatefulWidget {
  @override
  _KategoriPageState createState() => _KategoriPageState();
}

class _KategoriPageState extends State<KategoriPage> {
  FToast? fToast;
  
  @override
  void initState() {
    super.initState();
    fToast = FToast();
  }
  
  Widget iconTag({required Icon icon, required String tag}) {
    return IconButton(
      icon: icon,
      onPressed: () {
        fToast?.showToast(
          toastDuration: Duration(milliseconds: 2000),
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.grey,
            ),
            child: Text('Anda memilih kategori ' + tag),
          ),
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kategori Page')),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue, width: 3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('General'),
                  Container(height: 1.5, color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      iconTag(icon: Icon(Icons.attach_money), tag: 'General'),
                      iconTag(icon: Icon(Icons.card_travel), tag: 'General'),
                      iconTag(icon: Icon(Icons.local_hospital), tag: 'General'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue, width: 3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Entertainment'),
                  Container(height: 1.5, color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      iconTag(icon: Icon(Icons.fastfood), tag: 'Entertainment'),
                      iconTag(icon: Icon(Icons.hotel), tag: 'Entertainment'),
                      iconTag(
                        icon: Icon(Icons.local_grocery_store),
                        tag: 'Entertainment',
                      ),
                      iconTag(
                        icon: Icon(Icons.local_movies),
                        tag: 'Entertainment',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue, width: 3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Transportasi'),
                  Container(height: 1.5, color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      iconTag(
                        icon: Icon(Icons.directions_bike),
                        tag: 'Transportasi',
                      ),
                      iconTag(
                        icon: Icon(Icons.motorcycle),
                        tag: 'Transportasi',
                      ),
                      iconTag(
                        icon: Icon(Icons.directions_car),
                        tag: 'Transportasi',
                      ),
                      iconTag(
                        icon: Icon(Icons.local_shipping),
                        tag: 'Transportasi',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      iconTag(
                        icon: Icon(Icons.directions_bus),
                        tag: 'Transportasi',
                      ),
                      iconTag(
                        icon: Icon(Icons.directions_boat),
                        tag: 'Transportasi',
                      ),
                      iconTag(icon: Icon(Icons.train), tag: 'Transportasi'),
                      iconTag(
                        icon: Icon(Icons.airplanemode_active),
                        tag: 'Transportasi',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}