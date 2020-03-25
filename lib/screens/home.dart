import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_gas_cycle/databases/database.dart';
import 'package:my_gas_cycle/models/gas.model.dart';
import 'package:my_gas_cycle/screens/newgas.dart';

class MyHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _MyHomeState();
  }
}

class _MyHomeState extends State<MyHome>{

  final DBProvider db = new DBProvider();
  List<Gas> listGases = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: constructAppBar("Home"),
      body: constructHome(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewGas())
          );
        }
      ),
    );
  }
 
  Widget constructAppBar(String title){
    return AppBar(
      leading: Icon(Icons.home),
      title: Text(title)
    );
  }

  Future<void> loadingListGases() async {
    setState(() {
      db.getAllGas().then((gas){
        this.listGases = gas;
      });
    });
  }

  
  Widget constructInfoPeriodGas(){
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
        child: Column(
          children: <Widget>[
            Text(
              "Seu gás acaba em:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              )
            ),
            getDateNextGas()
          ],
        ),
      )
    );
  }

  Widget getDateNextGas(){
    final today = new DateTime.now().add(Duration(days: 30));
    final todayString = new DateFormat("dd/MM/yyyy").format(today).toString();
    return Text(
      todayString,
      style: TextStyle(
        color: Colors.deepPurple,
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget constructHome(){
    loadingListGases();
    return Stack(
      children: <Widget>[
        constructInfoPeriodGas(),
        constructlistCards()
      ],
      alignment: Alignment.center,
      overflow: Overflow.clip,
    );
  }

  Widget constructlistCards(){
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(0, 80, 0,0),
      child: ListView.builder(
        itemCount: this.listGases.length,
        itemBuilder: (context, index){
          return constructCard(this.listGases[index].kilograms,this.listGases[index].buyDate);
        }
      ),
    );
  }

  Widget constructCard(kilograms, buyDate){
    return SizedBox(
      height: 100,
      child: Card(
        margin: EdgeInsets.all(10),
        color: Colors.amberAccent,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('${kilograms.toString()}KG', style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text(buyDate),
              leading: Icon(
                Icons.history,
                color: Colors.deepPurple,
              ),
            )
          ],
        ),
      ),
    );
  }
//  Widget constructCardGas(String )
}