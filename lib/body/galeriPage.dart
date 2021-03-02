import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class GaleriPage extends StatefulWidget {
  @override
  _GaleriPageState createState() => _GaleriPageState();
}

class _GaleriPageState extends State<GaleriPage> {
  Future<List> getData() async {
    final response = await http
        .get("https://peternakanfajar.000webhostapp.com/get_galeri.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.black,
      child: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ItemList(list: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailBerita(list, index);
              }));
            },
            child: Container(
              child: Image.network(
                'https://peternakanfajar.000webhostapp.com/' +
                    list[index]['gambar'],
                fit: BoxFit.contain,
                width: 60.0,
                height: 60.0,
              ),
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class DetailBerita extends StatefulWidget {
  List list;
  int index;
  DetailBerita(this.list, this.index);

  @override
  _DetailBeritaState createState() => _DetailBeritaState();
}

class _DetailBeritaState extends State<DetailBerita> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Image.network('https://peternakanfajar.000webhostapp.com/' +
              widget.list[widget.index]['gambar']),
          Container(
            padding: EdgeInsets.all(32.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          widget.list[widget.index]['nama'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.brown),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(32.0),
            child: Text(
              widget.list[widget.index]['isi'],
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
