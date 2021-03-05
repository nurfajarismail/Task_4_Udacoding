import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:task_4/ui_loginreg/loginPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController cUsername = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  TextEditingController cPassword = TextEditingController();

//deklarasi untuk masing-masing widget
  String nUsername, nEmail, nPassword;

//menambahkan key form
  final _keyForm = GlobalKey<FormState>();

// saat user klik tombol register
  checkForm() {
    final form = _keyForm.currentState;
    if (form.validate()) {
      form.save();
      submitDataRegister();
    }
  }

// submit data register
  submitDataRegister() async {
    final responseData = await http
        .post("https://peternakanfajar.000webhostapp.com/register.php", body: {
      "username": nUsername,
      "email": nEmail,
      "password": nPassword,
    });
    final data = jsonDecode(responseData.body);
    int value = data['value'];
    String pesan = data['message'];
//cek value 1 atau 0
    if (value == 1) {
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    } else if (value == 2) {
      print(pesan);
    } else {
      print(pesan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _keyForm,
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                height: 200,
                child: Image.asset(
                  "assets/icon.png",
                  // color: Colors.brown,
                  scale: 2.0,
                ),
              ),
            ),
            Center(
              child: Text(
                'KANDANG',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0,
                    color: Colors.brown),
              ),
            ),
            Center(
              child: Text(
                'Kandangku Kandangmu',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.brown),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                controller: cUsername,
                validator: (value) {
                  //cek kalau value nya kosong
                  if (value.isEmpty) {
                    return 'Please Input UserName';
                  }
                  return null;
                },
                onSaved: (value) => nUsername = cUsername.text,
                decoration: InputDecoration(
                    hintText: 'username',
                    labelText: 'Input usermame',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                controller: cEmail,
                validator: (value) {
                  //cek kalau value nya kosong
                  if (value.isEmpty) {
                    return 'Please Input Email';
                  }
                  return null;
                },
                onSaved: (value) => nEmail = cEmail.text,
                decoration: InputDecoration(
                    hintText: 'Email',
                    labelText: 'Input Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: cPassword,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Input Password';
                  }
                  return null;
                },
                onSaved: (value) => nPassword = cPassword.text,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Input Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                      20.0,
                    ))),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0),
              child: MaterialButton(
                color: Colors.brown,
                textColor: Colors.white,
                child: Text('Register'),
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
                child: Text('Sudah Punya Akun ? Silahkan Login'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
