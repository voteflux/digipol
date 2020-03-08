import 'package:flutter/material.dart';
import 'package:voting_app/styles.dart';


class HouseIconsWidget extends StatelessWidget {
  dynamic billsMap;
  final Color senateColor = appColors.senate;
  final Color houseColor = appColors.house;
  final Color noFillColor = appColors.greyedOut;
  double size = 20;


  HouseIconsWidget({
    Key key,
    @required this.billsMap,
    @required this.size,

  }) : super(key: key);

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
  Map billsMap;
  bool voted;
  double size;

  VotingStatusWidget({
    Key key,
    @required this.billsMap,
    @required this.voted,
    @required this.size,

  }) : super(key: key);

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
              size: this.size,
            ),
            Text(
              statusMessage()[1],
              style: TextStyle(fontSize: this.size*4/10, fontWeight: FontWeight.bold, color: statusMessage()[0]),

            ),
          ],
        )
    );
  }
}





class CountUpWidget extends StatefulWidget {
  @override
  _CountUpWidgetState createState() => _CountUpWidgetState();
  int number;
  String text;
  List<int> delayers = [1,2,4,6,8,10,16,18,20];


  CountUpWidget({
    Key key,
    @required this.number,
    @required this.text,
  }) : super(key: key);

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


