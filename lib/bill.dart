import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/route_generator.dart';
import 'package:voting_app/styles.dart';
import 'package:voting_app/cutom_widgets.dart';

class BillPage extends StatelessWidget {

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
        backgroundColor: appColors.mainTheme,
        title: Text('Vote on Bill'),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Text(
                "PAGE UNDER CONSTRUCTION",
                style: TextStyle(fontSize: 30, color: Colors.red),

              ),
              VotingStatusWidget(billsMap: data, voted: false, size: 40),


              Text(
                data["Short Title"],
                style: TextStyle(fontSize: 30, color: appColors.text),

              ),
              HouseIconsWidget(billsMap: data, size: 40),
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
                          shape: BeveledRectangleBorder(),
                          onPressed: () {
                            // Pushing a named route
                            Navigator.of(context).pushNamed(
                              '/pdf',
                              arguments: data["text link pdf"],
                            );
                          },
                          padding: EdgeInsets.all(20),
                          color: Colors.blue,
                          child: Text("Full Bill Text",style: TextStyle(fontSize: 20, color: appColors.text)),
                        ),
                        FlatButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed(
                              '/pdf',
                              arguments: data["em link pdf"],
                            );
                          },
                          padding: EdgeInsets.all(20),
                          color: Colors.purple,
                          child: Text("EM",style: TextStyle(fontSize: 20, color: appColors.text)),
                        ),
                      ],
                    )
                ),
              ),
              Card(
                color: appColors.card,
                child: Container(
                  padding: EdgeInsets.all(40),
                    child: Row(
                      children: <Widget>[

                        FlatButton(
                          shape: BeveledRectangleBorder(),
                          onPressed: (){},
                          padding: EdgeInsets.all(20),
                          color: Colors.blue,
                          child: Text("Vote Yes",style: TextStyle(fontSize: 20, color: appColors.text)),
                        ),
                        FlatButton(
                          shape:RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)
                          ),
                          onPressed: (){
                            AlertDialog(
                              title: Text("Vote"),
                              content: Text("Are you sure you ant to vote?"),
                              actions: <Widget>[
                                FlatButton(child: Text("No"),),
                                FlatButton(child: Text("Yes"),),
                              ],
                              elevation: 24.0,
                            );
                          },
                          padding: EdgeInsets.all(20),
                          color: Colors.red,
                          child: Text("Vote No",style: TextStyle(fontSize: 20, color: appColors.text)),
                        ),
                      ],
                    )
                ),
              ),
            ],
          ),
        ),


      ),
    );
  }
}