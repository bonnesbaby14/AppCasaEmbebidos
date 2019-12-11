import 'sensor2.dart';
import 'package:flutter/material.dart';

typedef OnDelete();

class UserForm extends StatefulWidget {
  final Sensor2 user;
  final state = _UserFormState();
  final OnDelete onDelete;

  UserForm({Key key, this.user, this.onDelete}) : super(key: key);
  @override
  _UserFormState createState() => state;
}

class _UserFormState extends State<UserForm> {
  final form = GlobalKey<FormState>();

  @override
  void initState() {
   
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.verified_user),
                elevation: 0,
                title: Text('Habitación'),
                backgroundColor: Colors.black,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: TextFormField(
                  initialValue: widget.user.nombre,
                  onChanged: (val) => widget.user.nombre = val,
                  onSaved: (val) => widget.user.nombre = val,
                  decoration: InputDecoration(
                    labelText: 'Nombre de la habitacion',
                    hintText: 'Introduce el nombre',
                    icon: Icon(Icons.person),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (val) => widget.user.pinT = int.parse(val),
                  decoration: InputDecoration(
                    labelText: 'Pin Temperatura',
                    hintText: 'Pin de Temperatura',
                    icon: Icon(Icons.settings_input_component),
                    isDense: true,
                  ),
                ),
              ),
               Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  
                  onChanged:  (val) => widget.user.pinM = int.parse(val),
                  decoration: InputDecoration(
                    labelText: 'Pin movimiento',
                    hintText: 'Pin de movimiento',
                    icon: Icon(Icons.settings_input_component),
                    isDense: true,
                  ),
                ),
              ),
               Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  
                  onChanged:  (val) => widget.user.pinV = int.parse(val),
                  decoration: InputDecoration(
                    labelText: 'Pin ventana',
                    hintText: 'Pin de Ventanta',
                    icon: Icon(Icons.settings_input_component),
                    isDense: true,
                  ),
                ),
              ),
               Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  
                  onChanged:  (val) => widget.user.pinP = int.parse(val),
                  decoration: InputDecoration(
                    labelText: 'Pin Puerta',
                    hintText: 'Pin de Puerta',
                    icon: Icon(Icons.settings_input_component),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  
                  onChanged:  (val) => widget.user.pinL = int.parse(val),
                  decoration: InputDecoration(
                    labelText: 'Pin luz',
                    hintText: 'Pin ',
                    icon: Icon(Icons.settings_input_component),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (val) => widget.user.temp = int.parse(val),
                  decoration: InputDecoration(
                    labelText: 'Temperatura deseada',
                    hintText: 'Temperatura deseada',
                    icon: Icon(Icons.settings_input_component),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (val) => widget.user.luz = int.parse(val),
                  decoration: InputDecoration(
                    labelText: 'Nivel de luz para encendido',
                    hintText: 'Nivel de luz para encendido',
                    icon: Icon(Icons.settings_input_component),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///form validator

}
