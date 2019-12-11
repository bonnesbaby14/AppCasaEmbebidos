import 'sensor2.dart';
import 'package:flutter/material.dart';
import 'empty_state.dart';
import 'form.dart';
import 'package:http/http.dart' as http;

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<UserForm> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        leading: Icon(
          Icons.supervised_user_circle,
        ),
        title: Text('Registrar habitaciones'),
        actions: <Widget>[
          FlatButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: onSave,
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
  void onDelete(Sensor2 _user) {
    setState(() {
      var find = users.firstWhere(
        (it) => it.user == _user,
        orElse: () => null,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _user = Sensor2();
      users.add(UserForm(
        user: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }

  ///on save forms
  void onSave() async {
    var selectedTimeRTL = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child,
        );
      },
    );
    //hora se encenidido
    var selectedTimeRTL2 = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child,
        );
      },
    );
    var selectedTimeRTL3 = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child,
        );
      },
    );
    
    luzhora(
        (selectedTimeRTL2.hour.toString() +
            ":" +
            selectedTimeRTL2.minute.toString()),
        (selectedTimeRTL3.hour.toString() +
            ":" +
            selectedTimeRTL3.minute.toString()));
    horu(selectedTimeRTL.hour.toString() +
        ":" +
        selectedTimeRTL.minute.toString());

    for (var user in users) {
      await upSensor(user.user.nombre, user.user.pinT, user.user.pinM,
          user.user.pinV, user.user.pinP,user.user.pinL, user.user.temp, user.user.luz);
    }
  }

  Future upSensor(nombre, pinT, pinM, pinV, pinP,pinL, temp, luz) async {
    print("temperatura");
    var cliente1 = new http.Client();
    try {
      final response = await cliente1
          .post("http://192.168.1.73/smartHouse/setSensors.php", body: {
        "nombre": nombre,
        "pint": pinT.toString(),
        "pinm": pinM.toString(),
        "pinv": pinV.toString(),
        "pinp": pinP.toString(),
        "pinl": pinL.toString(),
        "temp": temp.toString(),
        "luz": luz.toString(),
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

  Future horu(fecha) async {
    print("fecha");
    var cliente1 = new http.Client();
    try {
      final response = await cliente1
          .post("http://192.168.1.73/smartHouse/setFecha.php", body: {
        "fecha": fecha,
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


  Future luzhora(hora, hora2) async {
    print("fecha");
    var cliente1 = new http.Client();
    try {
      final response = await cliente1.post(
          "http://192.168.1.73/smartHouse/setFecha2.php",
          body: {"hora": hora, "hora2": hora2}).timeout(Duration(seconds: 7));
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
