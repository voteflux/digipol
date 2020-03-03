import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voting_app/route_generator.dart';
import 'package:voting_app/api/aus_bills.dart';
import 'dart:math';

class AllIssuesPage extends StatelessWidget {
  List billsList = fetchBills();
  @override
  Widget build(BuildContext context) {
    List<Widget> billWidgetList = [];
    billsList.shuffle();
    for (var i in billsList) {
      billWidgetList.add(BillWidget(i));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: Text('Voting App'),
      ),
      body: Center(
        child: ListView(
          controller: ScrollController(),
            children: billWidgetList,
        ),
      ),
    );
  }
}

class BillWidget extends StatelessWidget {
  Map billsMap;
  Map billColors = {"House" : Colors.teal[100], "Senate" : Colors.deepPurple[100]};
  Map billColorsDark = {"House" : Colors.teal[600], "Senate" : Colors.deepPurple[600]};
  Map billIntro = {"House" : "Intro House", "Senate" : "Intro Senate"};
  Random random = new Random();
  BillWidget(Map m){
    this.billsMap = m;
  }
  @override
  Widget build(BuildContext context) {
      return Center(
          child: Container(
        decoration: BoxDecoration(
          boxShadow: [
          BoxShadow(
          color: billColorsDark[billsMap["Chamber"]],
          blurRadius: 5.0, // has the effect of softening the shadow
          spreadRadius: 2.0, // has the effect of extending the shadow
            offset: Offset(
              1.0, // horizontal, move right 10
              1.0, // vertical, move down 10
            ),
          )
          ],
          color: billColors[billsMap["Chamber"]],
//          border: Border.all(color: billColorsDark[billsMap["Chamber"]], width: 2,),
          borderRadius: BorderRadius.circular(5),
        ),
              margin: EdgeInsets.symmetric(vertical: 6,horizontal: 12),

              child: Card(
                  shadowColor: Colors.transparent,
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
//                        height: 140,
                          width: 500,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(0,0,0,20),
                                child: Text(
                                    billsMap["Short Title"],
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                      "Introduced in the"+ billsMap["Chamber"] +"\non: " + billsMap[billIntro[billsMap["Chamber"]]],
                                      style: TextStyle(fontSize: 10)),
                                  VotingStatusWidget(billsMap, random.nextInt(5) == 0)


                                ],
                              ),
                              HouseIconsWidget(billsMap),

                            ],
                          )
                      )

                  )
              )

          )
      );




  }
}

class HouseIconsWidget extends StatelessWidget {
  Map billsMap;
//  Map billHouseColors = {"House" : Colors.teal[200], "Senate" : Colors.deepPurple[200]};
//  Map billSenateColors = {"House" : Colors.deepPurple[200], "Senate" : Colors.teal[200] };
//  Map billHouseColorsOff = {"House" : Colors.teal[100], "Senate" : Colors.deepPurple[100]};
//  Map billSenateColorsOff = {"House" : Colors.deepPurple[100], "Senate" : Colors.teal[100] };
//  Map billIntro = {"House" : "Intro House", "Senate" : "Intro Senate"};

  HouseIconsWidget(Map m){
    this.billsMap = m;
  }

  hiChooser(Map theBill){
    if (theBill["Chamber"] == "House"){
      if (theBill["Intro House"] == ""){
        return Colors.teal[50];
      }else{
        return Colors.teal[300];
      }
    }else{
      if (theBill["Intro Senate"] == ""){
        return Colors.deepPurple[50];
      }else{
        return Colors.deepPurple[300];
      }
    }
  }
  hpChooser(Map theBill){
    if (theBill["Chamber"] == "House"){
      if (theBill["Passed House"] == ""){
        return Colors.teal[50];
      }else{
        return Colors.teal[300];
      }
    }else{
      if (theBill["Passed Senate"] == ""){
        return Colors.deepPurple[50];
      }else{
        return Colors.deepPurple[300];
      }
    }
  }
  siChooser(Map theBill){
      if (theBill["Chamber"] == "House"){
        if (theBill["Intro Senate"] == ""){
          return Colors.deepPurple[50];
        }else{
          return Colors.deepPurple[300];
        }
      }else{
        if (theBill["Intro House"] == ""){
          return Colors.teal[50];
        }else{
          return Colors.teal[300];
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

class VotingStatusWidget extends StatelessWidget {
  Map billsMap;
  bool voted;
  VotingStatusWidget(Map m, bool v){
    this.billsMap = m;
    this.voted = v;
  }

  statusMessage(){
    String s = "Voting Closed";
    Color c = Colors.red;
    var i = Icons.adjust;
    if (voted){
      s = "Voted";
      c = Colors.blue;
      i = Icons.check_circle_outline;
    }else{
      if (billsMap["Chamber"] == "House"){
        if (billsMap["Passed Senate"] == ""){
          s = "Voting Open";
          c = Colors.green;
          i = Icons.add_circle_outline;

        }
      }else{
        if (billsMap["Passed House"] == ""){
          s = "Voting Open";
          c = Colors.green;
          i = Icons.add_circle_outline;
        }
      }
    }

    return [c,s,i];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            Text(
              statusMessage()[1],
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: statusMessage()[0]),

            ),
            Icon(
            statusMessage()[2],
              color: statusMessage()[0],
              size: 20,
            ),
          ],
        )
    );
  }
}


