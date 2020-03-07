import 'package:flutter/material.dart';
import 'package:voting_app/route_generator.dart';
import 'package:voting_app/styles.dart';
import 'package:voting_app/all_bills.dart';

class BillPage extends StatelessWidget {
  // This is a String for the sake of an example.
  // You can use any type you want.
  final Map data;

  BillPage({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.background,
      appBar: AppBar(
        title: Text('Vote on Bill'),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              VotingStatusWidget(data,false,40),

              Text(
                data["Short Title"],
                style: TextStyle(fontSize: 30, color: appColors.text),

              ),
              Card(
                color: appColors.card,
                child: HouseIconsWidget(data, 40),
              ),
              Text(
                data["Summary"],
                style: TextStyle(fontSize: 20, color: appColors.text),
              ),
              Card(
                color: appColors.card,
                child: Container(
                  padding: EdgeInsets.all(40),
                    child: Row(
                      children: <Widget>[

                        FlatButton(
                          onPressed: (){},
                          padding: EdgeInsets.all(20),
                          color: Colors.blue,
                          child: Text("Vote Yes",style: TextStyle(fontSize: 20, color: appColors.text)),
                        ),
                        FlatButton(
                          onPressed: (){},
                          padding: EdgeInsets.all(20),
                          color: Colors.red,
                          child: Text("Vote No",style: TextStyle(fontSize: 20, color: appColors.text)),
                        ),
                      ],
                    )
                ),
              )
            ],
          ),
        ),


      ),
    );
  }
}