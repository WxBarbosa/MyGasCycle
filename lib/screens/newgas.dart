import 'package:flutter/material.dart';
import '../databases/database.dart';
import '../models/gas.model.dart';

class NewGas extends StatelessWidget{

  final DBProvider db = new DBProvider();

  @override
  Widget build(BuildContext context) {
    showGases();
    return Scaffold(
      appBar: constructAppBar("Home"),
      body: constructForm()
    );
  }

  Future<void> showGases() async {
    final gas = Gas(
      buyDate: DateTime.now().toString(),
      kilograms: 13
    );
    await db.insertGas(gas);
    List<Gas> result = await db.getAllGas();

    for (var item in result) {
       print(item.id);
       print(item.kilograms);
       print(item.buyDate);
       print(item.createdAt);
    }
  }

  Widget constructAppBar(String title){
    return AppBar(
      leading: Icon(Icons.home),
      title: Text(title)
    );
  }

  Widget constructForm(){
    return Text('2');
  }
}