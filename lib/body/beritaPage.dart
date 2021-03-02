import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PageHomeBerita extends StatefulWidget {
  @override
  _PageHomeBeritaState createState() => _PageHomeBeritaState();
}

class _PageHomeBeritaState extends State<PageHomeBerita> {
  Future<List> getData() async {
    final response = await http
        .get("https://peternakanfajar.000webhostapp.com/get_berita.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //   height: 200,
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
      scrollDirection: Axis.vertical,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailBerita(list, index);
              }));
            },
            child: Card(
              child: ListTile(
                title: Text(
                  list[index]['judul'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.brown),
                ),
                subtitle: Text("Tanggal :${list[index]['tgl_berita']}"),
                trailing: Image.network(
                  'https://peternakanfajar.000webhostapp.com/' +
                      list[index]['foto'],
                  fit: BoxFit.cover,
                  width: 60.0,
                  height: 60.0,
                ),
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
      appBar: AppBar(
        title: Text(widget.list[widget.index]['judul']),
        backgroundColor: Colors.brown,
      ),
      body: ListView(
        children: <Widget>[
          Image.network('https://peternakanfajar.000webhostapp.com/' +
              widget.list[widget.index]['foto']),
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
                          widget.list[widget.index]['judul'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.brown),
                        ),
                      ),
                      Text(widget.list[widget.index]['tgl_berita'])
                    ],
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.brown,
                )
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
