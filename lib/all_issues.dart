import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voting_app/route_generator.dart';
import 'package:voting_app/api/aus_bills.dart';
import 'dart:math';

class AllIssuesPage extends StatelessWidget {
  Color appThemeColor = Colors.blueAccent;
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
        backgroundColor: appThemeColor,
        title: Text('Federal Bills'),
      ),
      body: Center(
        child: ListView(
          controller: ScrollController(),
            children: billWidgetList,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: appThemeColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text('Bills'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_late),
            title: Text('Issues'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: Text('Profile'),
          ),
        ],
//          currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
//          onTap: _onItemTapped,
      ),
    );
  }
}

class BillWidget extends StatelessWidget {
  Map billsMap;
  Map billColors = {"House" : Colors.teal[100], "Senate" : Colors.deepPurple[100]};
  Map billColorsDark = {"House" : Colors.green[200], "Senate" : Color(0xFFebadd6)};
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
          color: Colors.black,
          blurRadius: 6.0, // has the effect of softening the shadow
          spreadRadius: 0.0, // has the effect of extending the shadow
            offset: Offset(
              1.0, // horizontal, move right 10
              1.0, // vertical, move down 10
            ),
          )
          ],
          color: billColorsDark[billsMap["Chamber"]],
          border: Border.all(color: Colors.black, width: 1,),
          borderRadius: BorderRadius.circular(4),
        ),
              margin: EdgeInsets.symmetric(vertical: 6,horizontal: 12),

              child: Card(
                  shadowColor: Colors.transparent,
//                  color: billColors[billsMap["Chamber"]],
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
                                padding: EdgeInsets.fromLTRB(5,5,5,0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                        "Introduced in the "+ billsMap["Chamber"] +"\n" + billsMap[billIntro[billsMap["Chamber"]]],
                                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500,fontStyle: FontStyle.italic)),
                                    VotingStatusWidget(billsMap, random.nextInt(5) == 0)


                                  ],
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.fromLTRB(10,10,5,20),
                                child: Text(
                                    billsMap["Short Title"],
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  HouseIconsWidget(billsMap),
                                  FlatButton(
                                    onPressed: (){},
                                    child: Icon(Icons.share, color: Colors.blueAccent,),
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
  Map billsMap;
  Color senateColor = Color(0xFFcc3399);
  Color houseColor = Colors.teal[300];
  Color noFillColor = Colors.grey[50];
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


