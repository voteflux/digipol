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

class HouseIconsWidget extends StatelessWidget {
  dynamic billsMap;
  final Color senateColor = appColors.senate;
  final Color houseColor = appColors.house;
  final Color noFillColor = appColors.greyedOut;
  double size = 20;
  HouseIconsWidget(Map m, double size){
    this.billsMap = m;
    this.size = size;
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
      height: this.size,
      width: this.size*8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.account_balance,
            color: hiChooser(billsMap),
            size: this.size,
          ),
          Icon(
            Icons.label_important,
            color: appColors.greyedOut,
            size: this.size,
          ),
          Icon(
            Icons.check_circle,
            color: hpChooser(billsMap),
            size: this.size,
          ),
          Icon(
            Icons.label_important,
            color: appColors.greyedOut,
            size: this.size,
          ),
          Icon(
            Icons.account_balance,
            color: siChooser(billsMap),
            size: this.size,
          ),
          Icon(
            Icons.label_important,
            color: appColors.greyedOut,
            size: this.size,
          ),
          Icon(
            Icons.check_circle,
            color: spChooser(billsMap),
            size: this.size,
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
    Color c = appColors.voteClosed;
    var i = Icons.adjust;
    if (voted){
      s = "Voted";
      c = appColors.voted;
      i = Icons.check_circle_outline;
    }else{
      if (billsMap["Chamber"] == "House"){
        if (billsMap["Passed Senate"] == ""){
          s = "Open";
          c = appColors.voteOpen;
          i = Icons.add_circle_outline;

        }
      }else{
        if (billsMap["Passed House"] == ""){
          s = "Open";
          c = appColors.voteOpen;
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


class BillsMessageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return       Center(
      child:       Card(
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
                  Text("A list of all Federal Bills", style: TextStyle(fontSize: 13, color: appColors.text,fontWeight: FontWeight.bold),),
                  Icon(Icons.subtitles, size: 80,color: appColors.text,),
                  Text("Vote on the Bills by scrolling and tapping", style: TextStyle(fontSize: 13, color: appColors.text,fontWeight: FontWeight.bold),),
                  Text("on the Bills that matter most to you", style: TextStyle(fontSize: 13, color: appColors.text,fontWeight: FontWeight.bold),),
                ],
              )
          )
      ),
    );
  }
}


class CountUpWidget extends StatefulWidget {
  @override
  _CountUpWidgetState createState() => _CountUpWidgetState();
  int number;
  String text;
  List<int> delayers = [1,2,4,6,8,10,16,18,20];
  CountUpWidget(int number, String text){
    this.number = number;
    this. text = text;
  }
}

class _CountUpWidgetState extends State<CountUpWidget> {


  int index = 0;
  int outputNumber = 0;
  var fw = FontWeight.normal;

  @override
  Widget build(BuildContext context) {

    if (index < widget.delayers.length){
      int d = widget.delayers[index];
      Future.delayed(Duration(milliseconds: d*16), () {
        setState(() {
          this.index  = this.index + 1;
          this.outputNumber = d*widget.number~/20;
        });

      });
    }else{
      fw = FontWeight.bold;
    }

    return Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Column(
            children: <Widget>[

              Text(widget.text, style: TextStyle(fontSize: 13, color: appColors.text,fontWeight: FontWeight.bold),),
              Text(this.outputNumber.toString(), style: TextStyle(fontSize: 50, color: appColors.text, fontWeight: fw),),
            ],
          ),
        )
    );
  }
}
