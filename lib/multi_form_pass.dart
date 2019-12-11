import 'package:flutter/cupertino.dart';
import 'package:pin_code_fields/user.dart';
import 'formPass.dart';
import 'multi_form.dart';
import 'sensor2.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'empty_state.dart';

import 'package:http/http.dart' as http;

int contador = 0;

class MultiFormPass extends StatefulWidget {
  @override
  _MultiFormPass createState() => _MultiFormPass();
}

class _MultiFormPass extends State<MultiFormPass> {
  List<UserFormPass> users = [];
  bool f = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        leading: Icon(
          Icons.supervised_user_circle,
        ),
        title: Text('Contraseñas'),
        actions: <Widget>[
          FlatButton(
            child: Text('Siguiente'),
            textColor: Colors.white,
            onPressed: () async {
              await onSave();

              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => MultiForm()));
            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF727272),
              Color(0xFF282423),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: users.length <= 0
            ? Center(
                child: EmptyState(
                  title: 'Oops',
                  message: 'No hay sensores añadidos',
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, i) => users[i],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: onAddForm,
        focusColor: Colors.black,
        backgroundColor: Colors.black,
        foregroundColor: Colors.black,
      ),
    );
  }

  ///on form user deleted
  void onDelete(User _user) {
    setState(() {
      contador--;
      var find = users.firstWhere(
        (it) => it.user == _user,
        orElse: () => null,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    if (contador < 2) {
      setState(() {
        var _user = User();
        contador++;
        users.add(UserFormPass(
          user: _user,
          onDelete: () => onDelete(_user),
        ));
      });
    }
  }

  ///on save forms
  void onSave() async {
    for (var user in users) {
      if (f) {
        await upPass(user.user.password);
        f = false;
      } else {
        await upPass2(user.user.password);
      }
    }
  }

  Future upPass(nombre) async {
    print("temperatura");
    var cliente1 = new http.Client();
    try {
      final response = await cliente1
          .post("http://192.168.1.73/smartHouse/setPassword.php", body: {
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

  Future upPass2(nombre) async {
    print("temperatura2");
    var cliente1 = new http.Client();
    try {
      final response = await cliente1
          .post("http://192.168.1.73/smartHouse/setPassword2.php", body: {
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
}
