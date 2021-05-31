import 'package:shared_preferences/shared_preferences.dart';

import 'pages/RootApp.dart';
import 'theme/colors.dart';
import 'theme/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSenha = TextEditingController();
  double imgWidth = 300;
  double imgHeight = 300;

  @override
  initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    txtEmail.clear();
    txtSenha.clear();
  }

  void makeToast(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  Future<void> _tryLogin() async {
    try {
      String email = txtEmail.text;
      String password = txtSenha.text;

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // await FlutterSession().set('id', userCredential.user!.uid.toString());

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("id", userCredential.user!.uid.toString());

      makeToast("Logado com sucesso");

      Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
    } on FirebaseAuthException catch (e) {
      String errorText = e.code;

      if (e.code == 'user-not-found') {
        errorText = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorText = 'Wrong password provided for that user.';
      }

      makeToast(errorText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[350],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AnimatedContainer(
                      width: imgWidth,
                      height: imgHeight,
                      duration: Duration(milliseconds: 30),
                      child: Image.network(
                          "https://raw.githubusercontent.com/piresflp/event-manager/master/assets/images/Even7.png?token=ALKE34ILO7TAHVIYD6HOYGLAXYJXQ"),
                    ),
                    Text("Faça seu login!", style: customTitle),
                    SizedBox(height: 30),
                    TextField(
                      controller: txtEmail,
                      onTap: () {
                        setState(() {
                          imgWidth = 300;
                          imgHeight = 100;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        labelStyle: TextStyle(color: black),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: txtSenha,
                      onTap: () {
                        setState(() {
                          imgWidth = 300;
                          imgHeight = 100;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Senha",
                          labelStyle: TextStyle(color: black),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    SizedBox(height: 30),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tight(Size(double.infinity, 55)),
                      child: ElevatedButton(
                        onPressed: _tryLogin,
                        child: Text(
                          "Entrar",
                          style: TextStyle(color: white, fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: cyan,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7))),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
