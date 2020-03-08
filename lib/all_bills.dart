import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voting_app/route_generator.dart';
import 'package:voting_app/api/aus_bills.dart';
import 'dart:math';
import 'package:voting_app/styles.dart';
import 'package:voting_app/cutom_widgets.dart';

int index = 0;

class AllBillsPage extends StatelessWidget {
  final List billsList = fetchBills();

  @override
  Widget build(BuildContext context) {
    int billNum = billsList.length;
    List<Widget> billWidgetList = [
      CountUpWidget(billNum, "TOTAL BILLS"),
      BillsMessageWidget()
    ];
//    billsList.shuffle();
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
          color: appColors.card,
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
                            VotingStatusWidget(billsMap, random.nextInt(5) == 0,20),
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
                          HouseIconsWidget(billsMap, 20),
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


class BillsMessageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 40),
          elevation: 5.0,
          shadowColor: Colors.black,
          color: appColors.card,
          child: Container(
              padding: EdgeInsets.all(20),
//              height: 150,
              width: 300,
              child: Column(
                children: <Widget>[
                  Text("A list of all Federal Bills", style: TextStyle(fontSize: 15, color: appColors.text,fontWeight: FontWeight.bold),),
//                  Icon(Icons.subtitles, size: 80,color: appColors.text,),
                  Container(
                    height: 100,
                    width: 100,
                    child: Image(image: AssetImage('assets/graphics/point.png')),

                  ),
                  Text("Vote on the Bills by scrolling and tapping on the Bills that matter most to you", style: TextStyle(fontSize: 13, color: appColors.text,fontWeight: FontWeight.bold),),
                ],
              )
          )
      ),
    );
  }
}

