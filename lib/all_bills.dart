import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voting_app/route_generator.dart';
import 'package:voting_app/api/aus_bills.dart';
import 'dart:math';
import 'package:voting_app/styles.dart';

int index = 0;

class AllBillsPage extends StatelessWidget {
  final List billsList = fetchBills();
  @override
  Widget build(BuildContext context) {
    List<Widget> billWidgetList = [];
    billsList.shuffle();
    for (var i in billsList) {
      billWidgetList.add(BillWidget(i));
    }
    return Center(
        child: ListView(
          controller: ScrollController(),
          children: billWidgetList,
        ),
      );
  }
}

class BillWidget extends StatelessWidget {
  dynamic billsMap;
//  final Map billColors = {"House" : Colors.teal[100], "Senate" : Colors.deepPurple[100]};
  final Map billColorsDark = {"House" : appColors.house, "Senate" : appColors.senate};
  final Map billIntro = {"House" : "Intro House", "Senate" : "Intro Senate"};
  final Random random = new Random();
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
                  color: Colors.black,
                  blurRadius: 6.0, // has the effect of softening the shadow
                  spreadRadius: 0.0, // has the effect of extending the shadow
                  offset: Offset(
                    1.0, // horizontal, move right 10
                    1.0, // vertical, move down 10
                  ),
                )
              ],
              color: appColors.mainTheme,
              border: Border.all(color: Colors.black, width: 1,),
              borderRadius: BorderRadius.circular(4),
            ),
            margin: EdgeInsets.symmetric(vertical: 6,horizontal: 12),

            child: Card(
//                  shadowColor: Colors.transparent,
                color: appColors.background,
                child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      // Pushing a named route
                      Navigator.of(context).pushNamed(
                        '/bill',
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
                              padding: EdgeInsets.fromLTRB(5,5,5,0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                      "Introduced in the "+ billsMap["Chamber"] +"\n" + billsMap[billIntro[billsMap["Chamber"]]],
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800,fontStyle: FontStyle.italic, color: billColorsDark[billsMap["Chamber"]])),
                                  VotingStatusWidget(billsMap, random.nextInt(5) == 0)


                                ],
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.fromLTRB(10,10,5,20),
                              child: Text(
                                  billsMap["Short Title"],
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: appColors.text)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                HouseIconsWidget(billsMap),
                                FlatButton(
                                  onPressed: (){},
                                  child: Icon(Icons.assessment, color: appColors.text,),
                                ),
                              ],
                            ),


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
  dynamic billsMap;
  final Color senateColor = appColors.senate;
  final Color houseColor = appColors.house;
  final Color noFillColor = appColors.greyedOut;

  HouseIconsWidget(Map m){
    this.billsMap = m;
  }

  hiChooser(Map theBill){
    if (theBill["Chamber"] == "House"){
      if (theBill["Intro House"] == ""){
        return noFillColor;
      }else{
        return houseColor;
      }
    }else{
      if (theBill["Intro Senate"] == ""){
        return noFillColor;
      }else{
        return senateColor;
      }
    }
  }
  hpChooser(Map theBill){
    if (theBill["Chamber"] == "House"){
      if (theBill["Passed House"] == ""){
        return noFillColor;
      }else{
        return houseColor;
      }
    }else{
      if (theBill["Passed Senate"] == ""){
        return noFillColor;
      }else{
        return senateColor;
      }
    }
  }
  siChooser(Map theBill){
    if (theBill["Chamber"] == "House"){
      if (theBill["Intro Senate"] == ""){
        return noFillColor;
      }else{
        return senateColor;
      }
    }else{
      if (theBill["Intro House"] == ""){
        return noFillColor;
      }else{
        return houseColor;
      }
    }
  }
  spChooser(Map theBill){
    if (theBill["Chamber"] == "House"){
      if (theBill["Passed Senate"] == ""){
        return noFillColor;
      }else{
        return senateColor;
      }
    }else{
      if (theBill["Passed House"] == ""){
        return noFillColor;
      }else{
        return houseColor;
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
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
            color: appColors.greyedOut,
            size: 20,
          ),
          Icon(
            Icons.check_circle,
            color: hpChooser(billsMap),
            size: 20,
          ),
          Icon(
            Icons.label_important,
            color: appColors.greyedOut,
            size: 20,
          ),
          Icon(
            Icons.account_balance,
            color: siChooser(billsMap),
            size: 20,
          ),
          Icon(
            Icons.label_important,
            color: appColors.greyedOut,
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
  dynamic billsMap;
  dynamic voted;
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


