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
    int billNum = billsList.length;
    List<Widget> billWidgetList = [
      Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Column(
            children: <Widget>[

              Text("TOTAL BILLS", style: TextStyle(fontSize: 13, color: appColors.text,fontWeight: FontWeight.bold),),
              Text(billNum.toString(), style: TextStyle(fontSize: 50, color: appColors.text),),
            ],
          ),
        )
      ),
      Center(
        child:       Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 40),
            elevation: 5.0,
            shadowColor: Colors.black,
            color: appColors.background,
            child: Container(
            padding: EdgeInsets.all(20),
//              height: 150,
              width: 300,
              child: Column(
                children: <Widget>[
                  Text("A list of all Federal Bills", style: TextStyle(fontSize: 13, color: appColors.text,fontWeight: FontWeight.bold),),
                  Icon(Icons.subtitles, size: 80,color: appColors.text,),
                  Text("Vote on the Bills by scrolling and tapping", style: TextStyle(fontSize: 13, color: appColors.text,fontWeight: FontWeight.bold),),
                  Text("on the Bills that matter most to you", style: TextStyle(fontSize: 13, color: appColors.text,fontWeight: FontWeight.bold),),
                ],
              )
            )
        ),
      )



    ];
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
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          elevation: 5.0,
          shadowColor: Colors.black,
          color: appColors.background,
          child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                // Pushing a named route
                Navigator.of(context).pushNamed(
                  '/item',
                  arguments: billsMap,
                );
              },
              child: Container(
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            VotingStatusWidget(billsMap, random.nextInt(5) == 0),
                            Text(
                                billsMap[billIntro[billsMap["Chamber"]]],
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800,fontStyle: FontStyle.italic, color: billColorsDark[billsMap["Chamber"]])),



                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(15),
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
      margin: EdgeInsets.all(10),
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
    String s = "Closed";
    Color c = Colors.red;
    var i = Icons.adjust;
    if (voted){
      s = "Voted";
      c = Colors.blue;
      i = Icons.check_circle_outline;
    }else{
      if (billsMap["Chamber"] == "House"){
        if (billsMap["Passed Senate"] == ""){
          s = "Open";
          c = Colors.green;
          i = Icons.add_circle_outline;

        }
      }else{
        if (billsMap["Passed House"] == ""){
          s = "Open";
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
        child: Column(
          children: <Widget>[
            Icon(
              statusMessage()[2],
              color: statusMessage()[0],
              size: 20,
            ),
            Text(
              statusMessage()[1],
              style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: statusMessage()[0]),

            ),
          ],
        )
    );
  }
}


