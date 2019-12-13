
import 'data.dart';
import 'wallets.dart';
import 'wallet.dart';
import 'package:charts_flutter/flutter.dart'as charts;
import 'package:flutter/material.dart';


import 'home.dart';



class Wallets extends StatefulWidget {
  @override
  _WalletsState createState() => _WalletsState();
}

class _WalletsState extends State<Wallets> {

@override
  void initState() {
  
    // TODO: implement initState

    super.initState();
  }
var personas;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:sensores==null? ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        primary: false,
        itemCount: coins.length,
        itemBuilder: (BuildContext context, int index) {
          Map coin = coins[index];
personas=casita[0]['personas'];
          return Wallet(
            name: coin['name'],
            icon: coin['icon'],
            rate: coin['rate'],
            color: coin['color'],
          );
        },
      ):ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        primary: false,
        itemCount: sensores.length,
        itemBuilder: (BuildContext context, int index) {
          if(casita.length>0){
personas=casita[0]['personas'];
          }

          return Wallet(
            name: sensores[index]['nombre'],
            icon: "assets/eth.png",
            rate: "Temperatura"+sensores[index]['valorT']+""+"Ventana:"+sensores[index]['valorM']+"\n Luz:"+sensores[index]['valorL'] +" personas:"+personas.toString() ,
            color:charts.MaterialPalette.blue.shadeDefault,
          );
        },
      ),
    );
  }























}

