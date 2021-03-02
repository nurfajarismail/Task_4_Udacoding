import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_4/body/beritaPage.dart';
import 'package:task_4/body/galeriPage.dart';
import 'package:task_4/body/kamusPage.dart';

class HomePage extends StatefulWidget {
  final VoidCallback signOut;
  HomePage(this.signOut);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

        //
        appBar: AppBar(
          title: Text('Selamat datang ' + username),

          ///buat hilangin tombol back
          backgroundColor: Colors.brown,
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                signOut();
              },
            ),
          ],
        ),
        body: Center(
          child: Container(
            child: Column(
              children: [
                KamusPage(),
                GaleriPage(),
                Expanded(child: PageHomeBerita())
              ],
            ),
          ),
        ));
  }
}
