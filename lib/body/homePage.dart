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

        // //
        // appBar: AppBar(
        //   title: Text('Selamat datang ' + username),

        //   ///buat hilangin tombol back
        //   backgroundColor: Colors.brown,
        //   actions: [
        //     IconButton(
        //       icon: Icon(Icons.exit_to_app),
        //       onPressed: () {
        //         signOut();
        //       },
        //     ),
        //   ],
        // ),
        body: Center(
      child: Container(
        padding: EdgeInsets.only(top: 30, bottom: 5),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.brown,
                border: Border.all(color: Colors.brown),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    Icons.person,
                    color: Colors.brown,
                  ),
                  radius: 30.0,
                  backgroundColor: Colors.white,
                ),
                title: Text(
                  username,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    signOut();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => KamusPage()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cari istilah . . ."),
                        Icon(Icons.search)
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.brown),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
            ),
            Container(
              child: Row(children: <Widget>[
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: Divider(
                        color: Colors.black,
                        //   height: height,
                      )),
                ),
                Text("Galeri"),
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                      child: Divider(
                        color: Colors.black,
                        //height: height,
                      )),
                ),
              ]),
            ),
            GaleriPage(),
            Container(
              child: Row(children: <Widget>[
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: Divider(
                        color: Colors.black,
                        //   height: height,
                      )),
                ),
                Text("Berita"),
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                      child: Divider(
                        color: Colors.black,
                        //height: height,
                      )),
                ),
              ]),
            ),
            Expanded(child: PageHomeBerita())
          ],
        ),
      ),
    ));
  }
}
