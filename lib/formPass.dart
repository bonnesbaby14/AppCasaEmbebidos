import 'package:pin_code_fields/user.dart';

import 'sensor2.dart';
import 'package:flutter/material.dart';

typedef OnDelete();

class UserFormPass extends StatefulWidget {
  final User user;
  final state = _UserFormPass();
  final OnDelete onDelete;

  UserFormPass({Key key, this.user, this.onDelete}) : super(key: key);
  @override
  _UserFormPass createState() => state;
}

class _UserFormPass extends State<UserFormPass> {
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
                title: Text('Usuario'),
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
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  
                  onChanged:  (val) => widget.user.password = val,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: 'Contraseña',
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
