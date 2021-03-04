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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(10),
      height: 200,
      // color: Colors.black,
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
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Container(
          //height: 200,
          padding: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailGaleri(list, index);
              }));
            },
            child: Container(
              height: 200,
              child: Image.network(
                'https://peternakanfajar.000webhostapp.com/' +
                    list[index]['gambar'],
                fit: BoxFit.fill,
                height: 100.0,
              ),
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class DetailGaleri extends StatefulWidget {
  List list;
  int index;
  DetailGaleri(this.list, this.index);

  @override
  _DetailGaleriState createState() => _DetailGaleriState();
}

class _DetailGaleriState extends State<DetailGaleri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Image.network('https://peternakanfajar.000webhostapp.com/' +
                widget.list[widget.index]['gambar']),
          ),
          Container(
            padding: EdgeInsets.all(32.0),
            child: Expanded(
              child: Center(
                child: Container(
                  //padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    widget.list[widget.index]['nama'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.brown),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(32.0),
            child: Text(
              widget.list[widget.index]['isi'],
              textAlign: TextAlign.justify,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
