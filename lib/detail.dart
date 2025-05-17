import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    this.judul,
    this.content,
    this.datetime,
    this.image,
  }) : super(key: key);
  
  final String? judul;
  final String? content;
  final String? datetime;
  final String? image;
  
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 80),
          child: ListView(
            children: [
              Text(
                widget.judul ?? 'No Title',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                widget.datetime ?? 'No Date Provided',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 20),
              widget.image != null
                ? Image.network(
                    widget.image!,
                    height: 200,
                  )
                : Container(),
              SizedBox(height: 20),
              Text(
                widget.content ?? 'No Content Available',
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}