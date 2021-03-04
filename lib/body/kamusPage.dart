import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class KamusPage extends StatefulWidget {
  @override
  _KamusPageState createState() => _KamusPageState();
}

class _KamusPageState extends State<KamusPage> {
  Future<List> getData() async {
    final response = await http
        .get("https://peternakanfajar.000webhostapp.com/get_berita.php");
    return json.decode(response.body);
  }

  Icon sr = Icon(Icons.search);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kamus Istilah"),
        backgroundColor: Colors.brown,
      ),
      body: FutureBuilder<List>(
          future: getData(),
          builder: (ctx, ss) {
            if (ss.hasError) {
              print("Error");
            }
            if (ss.hasData) {
              return Items(list: ss.data);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class Items extends StatefulWidget {
  final List list;

  Items({@required this.list});

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List filteredList = [];
    if (_controller.text != null && _controller.text.isNotEmpty) {
      widget.list.forEach((item) {
        if (item['judul']
            .toString()
            .toLowerCase()
            .contains(_controller.text.toLowerCase())) filteredList.add(item);
      });
    } else
      filteredList = widget.list;
    return Column(children: <Widget>[
      Container(
        padding: EdgeInsets.all(10),
        child: TextField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.brown, width: 2.0),
              ),
              hintText: 'Masukkan kata',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.brown, width: 2),
              ),
            ),
            controller: _controller,
            onChanged: (text) => setState(() {})),
      ),
      Expanded(
        child: ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailBerita(filteredList, index);
                  }));
                },
                child: Card(
                  child: ListTile(
                      title: Text(filteredList[index]['judul'].toString())),
                ),
              );
            }),
      ),
    ]);
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
              textAlign: TextAlign.justify,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
