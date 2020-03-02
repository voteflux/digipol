import 'package:flutter/material.dart';
import 'package:voting_app/route_generator.dart';
import 'package:voting_app/api/aus_bills.dart';

class AllIssuesPage extends StatelessWidget {
  List billsList = fetchBills();
  @override
  Widget build(BuildContext context) {
    List<Widget> billWidgetList = [];
    for (var i in billsList) {
      billWidgetList.add(BillWidget(i));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Routing App'),
      ),
      body: Center(
        child: ListView(
            children: billWidgetList,
        ),
      ),
    );
  }
}

class BillWidget extends StatelessWidget {
  Map billsMap;
  Map billColors = {"House" : Colors.teal[50], "Senate" : Colors.deepPurple[50]};
  Map billIntro = {"House" : "Intro House", "Senate" : "Intro Senate"};
  BillWidget(Map m){
    this.billsMap = m;
  }
  @override
  Widget build(BuildContext context) {
      return Center(
          child: Card(
            color: billColors[billsMap["Chamber"]],
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                // Pushing a named route
                Navigator.of(context).pushNamed(
                  '/issue',
                  arguments: billsMap,
                );
              },
                child: Container(
                  height: 100,
                  width: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[

                        Text(

                            billsMap["Short Title"],
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        Text(
                            "Introduced on: " + billsMap[billIntro[billsMap["Chamber"]]],
                            style: TextStyle(fontSize: 10)),
                        HouseIconsWidget(billsMap),

                      ],
                    )
                )

            )
          )
      );


  }
}

class HouseIconsWidget extends StatelessWidget {
  Map billsMap;
  Map billHouseColors = {"House" : Colors.teal[200], "Senate" : Colors.deepPurple[200]};
  Map billSenateColors = {"House" : Colors.deepPurple[200], "Senate" : Colors.teal[200] };
  Map billHouseColorsOff = {"House" : Colors.teal[50], "Senate" : Colors.deepPurple[50]};
  Map billSenateColorsOff = {"House" : Colors.deepPurple[50], "Senate" : Colors.teal[50] };
  Map billIntro = {"House" : "Intro House", "Senate" : "Intro Senate"};

  HouseIconsWidget(Map m){
    this.billsMap = m;
  }

  hiChooser(Map theBill){
    if (theBill["Chamber"] == "House"){
      if (theBill["Intro House"] == ""){
        return Colors.teal[50];
      }else{
        return Colors.teal[200];
      }
    }else{
      if (theBill["Intro Senate"] == ""){
        return Colors.deepPurple[50];
      }else{
        return Colors.deepPurple[200];
      }
    }
  }
  hpChooser(Map theBill){
    if (theBill["Chamber"] == "House"){
      if (theBill["Passed House"] == ""){
        return Colors.teal[50];
      }else{
        return Colors.teal[200];
      }
    }else{
      if (theBill["Passed Senate"] == ""){
        return Colors.deepPurple[50];
      }else{
        return Colors.deepPurple[200];
      }
    }
  }
  siChooser(Map theBill){
      if (theBill["Chamber"] == "House"){
        if (theBill["Intro Senate"] == ""){
          return Colors.deepPurple[50];
        }else{
          return Colors.deepPurple[200];
        }
      }else{
        if (theBill["Intro House"] == ""){
          return Colors.teal[50];
        }else{
          return Colors.teal[200];
        }
      }
  }
  spChooser(Map theBill){
    if (theBill["Chamber"] == "House"){
      if (theBill["Passed Senate"] == ""){
        return Colors.deepPurple[50];
      }else{
        return Colors.deepPurple[200];
      }
    }else{
      if (theBill["Passed House"] == ""){
        return Colors.teal[50];
      }else{
        return Colors.teal[200];
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 160,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.account_balance,
            color: hiChooser(billsMap),
            size: 20,
          ),
          Icon(
            Icons.label_important,
            color: Colors.grey,
            size: 20,
          ),
          Icon(
            Icons.check_circle,
            color: hpChooser(billsMap),
            size: 20,
          ),
          Icon(
            Icons.label_important,
            color: Colors.grey,
            size: 20,
          ),
          Icon(
            Icons.account_balance,
            color: siChooser(billsMap),
            size: 20,
          ),
          Icon(
            Icons.label_important,
            color: Colors.grey,
            size: 20,
          ),
          Icon(
            Icons.check_circle,
            color: spChooser(billsMap),
            size: 20,
          ),
        ],
      ),
    );
  }
}
