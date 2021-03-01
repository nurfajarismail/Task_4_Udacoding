import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_4/beritaPage.dart';
import 'package:task_4/galeriPage.dart';

class PageHome extends StatefulWidget {
  final VoidCallback signOut;
  PageHome(this.signOut);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  //tambahan method signout
  signOut() async {
    setState(() {
      widget.signOut();
    });
  }

//mengambil nilai dari shared preferences
  String username = "";
  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences.getString("username");
    });
  }

  @override
  void initState() {
// ignore: todo
// TODO: implement initState
    super.initState();
    getDataPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(child: Center(child: Text(username))),
              ListTile(
                title: Text("Berita"),
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => PageHomeBerita()));
                },
              ),
              ListTile(
                title: Text("Galeri"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GaleriPage()));
                },
              ),
              ListTile(
                title: Text("Kamus"),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, PageHomeBerita().toStringShort());
                },
              ),
              ListTile(
                title: Text("Log Out"),
                onTap: () {
                  signOut();
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          //title: Text('Hi, ' + username),
          ///buat hilangin tombol back
          backgroundColor: Colors.blueGrey,
        ),
        body: PageHomeBerita());
  }
}
