import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/home.dart';
import 'package:pin_code_fields/multi_form.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'multi_form_pass.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PinCodeVerificationScreen(
          "+8801376221100"), // a random number, please don't call xD
    );
  }
}

class PinCodeVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  PinCodeVerificationScreen(this.phoneNumber);
  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  /// this [StreamController] will take input of which function should be called

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: FlareActor(
                  "assets/otp.flr",
                  animation: "otp",
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Accede a los datos de tu casa',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    length: 5,
                    obsecureText: false,
                    animationType: AnimationType.fade,
                    shape: PinCodeFieldShape.box,
                    animationDuration: Duration(milliseconds: 300),
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    backgroundColor: Colors.white,
                    fieldWidth: 40,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                  )),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  if (currentText.length < 5) return;
                  await upManager(currentText);
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => MultiFormPass()));
                  print("configurar nueva casa");
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "¿Nueva casa? ",
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                      children: [
                        TextSpan(
                            text: " CONFIGURAR",
                            style: TextStyle(
                                color: Color(0xFF91D3B3),
                                fontWeight: FontWeight.bold,
                                fontSize: 16))
                      ]),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  height: 50,
                  child: FlatButton(
                    onPressed: () async {
                      // conditions for validating
                      await login(currentText);

                      print("se inytento acceder");
                    },
                    child: Center(
                        child: Text(
                      "VERIFY".toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.green.shade200,
                          offset: Offset(1, -2),
                          blurRadius: 5),
                      BoxShadow(
                          color: Colors.green.shade200,
                          offset: Offset(-1, 2),
                          blurRadius: 5)
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future upManager(nombre) async {
    print("temperatura");
    var cliente1 = new http.Client();
    try {
      final response = await cliente1
          .post("http://192.168.1.73/smartHouse/setManager.php", body: {
        "nombre": nombre.toString(),
      }).timeout(Duration(seconds: 7));
      print(response.body);
    } catch (d) {
      print("hubo un error obteniendo los sensores");
      print(d.toString());
    } finally {
      cliente1.close();
      setState(() {});
    }
  }

  Future login(nombre) async {
    print("temperatura");
    var cliente1 = new http.Client();
    try {
      final response = await cliente1
          .post("http://192.168.1.73/smartHouse/login.php", body: {
        "nombre": nombre.toString(),
      }).timeout(Duration(seconds: 7));
      print(response.body);
      if(response.body=="1"){

        Navigator.push(context, CupertinoPageRoute(builder: (context)=>Home()));

      }
    } catch (d) {
      print("hubo un error obteniendo los sensores");
      print(d.toString());
    } finally {
      cliente1.close();
      setState(() {});
    }
  }
}
