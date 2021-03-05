import 'dart:convert';
import 'dart:core';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_4/body/homePage.dart';
import 'package:task_4/ui_loginreg/registerPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum statusLogin { signIn, notSignIn }

class _LoginPageState extends State<LoginPage> {
  statusLogin _loginStatus = statusLogin.notSignIn;
  final _keyForm = GlobalKey<FormState>();
  String nUsername, nPassword;

// check ketika klik tombol login
  checkForm() {
    final form = _keyForm.currentState;
    if (form.validate()) {
      form.save();
      submitDataLogin();
    }
  }

// mengirim request dan menanggapinya
  submitDataLogin() async {
    final responseData = await http
        .post("https://peternakanfajar.000webhostapp.com/login.php", body: {
      "username": nUsername,
      "password": nPassword,
    });
    final data = jsonDecode(responseData.body);
    int value = data['value'];
    String pesan = data['message'];
    print(data);
// get data respon
    String dataUsername = data['username'];
    String dataEmail = data['email'];
    String dataTanggalDaftar = data['tgl_daftar'];
    String dataIdUser = data['id_user'];
// cek value 1 atau 0
    if (value == 1) {
      setState(() {
// set status loginnya sebagai login
        _loginStatus = statusLogin.signIn;

        saveDataPref(
            value, dataIdUser, dataUsername, dataEmail, dataTanggalDaftar);
      });
    } else if (value == 2) {
      print(pesan);
    } else {
      Fluttertoast.showToast(
        msg: "Username atau password salah",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.brown,
        textColor: Colors.white,
      );
      //print(pesan);
      //print("Login raiso");
    }
  }

// method untuk soimpan share pref
  saveDataPref(int value, String dIdUser, dUsername, dEmail, dCreated) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("value", value);
      sharedPreferences.setString("username", dUsername);
      sharedPreferences.setString("id_user", dIdUser);
      sharedPreferences.setString("email", dEmail);
      sharedPreferences.setString("tgl_daftar", dCreated);
    });
  }

  ///
  /// method ini digunakan untuk mengecek apakah user sudah login atau belum

  /// jika sudah set valuenya
  ///
  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      int nvalue = sharedPreferences.getInt("value");
      _loginStatus = nvalue == 1 ? statusLogin.signIn : statusLogin.notSignIn;
    });
  }

  @override
  void initState() {
    getDataPref();
    super.initState();
  }

//method untuk sign out
  signOUt() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("value", null);
      // ignore: deprecated_member_use
      sharedPreferences.commit();
      _loginStatus = statusLogin.notSignIn;
    });
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case statusLogin.notSignIn:
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _keyForm,
              child: ListView(
                children: <Widget>[
                  Center(
                    child: Text(
                      'Login Form',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // Image.asset(
                  //   'images/udacoding.jpg',
                  //   height: 100.0,
                  //   width: 100.0,
                  // ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      validator: (value) {
//cek kalau value nya kosong
                        if (value.isEmpty) {
                          return 'Please Input Username';
                        }
                        return null;
                      },
                      onSaved: (value) => nUsername = value,
                      decoration: InputDecoration(
                          hintText: 'Username',
                          labelText: 'Input Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Input Password';
                        }
                        return null;
                      },
                      onSaved: (value) => nPassword = value,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Input Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0),
                    child: MaterialButton(
                      color: Colors.brown,
                      textColor: Colors.white,
                      child: Text('Login'),
                      onPressed: () {
                        setState(() {
                          checkForm();
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
                    child: MaterialButton(
                      textColor: Colors.blueGrey,
                      child: Text('Belum Punya Akun ? Silahkan Daftar'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
        break;
      case statusLogin.signIn:
        return HomePage(signOUt);
        break;
    }
  }
}
