import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/route_generator.dart';
import 'package:voting_app/styles.dart';
import 'package:voting_app/cutom_widgets.dart';
import 'package:pie_chart/pie_chart.dart';

class BillPage extends StatelessWidget {
  final Map data;

  BillPage({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.9;
    if (c_width > 1200) {
      c_width = 1200;
    }
    return Scaffold(
      backgroundColor: appColors.background,
      appBar: AppBar(
        backgroundColor: appColors.mainTheme,
        title: Text('Vote on Bill'),
      ),
      body: Center(
        child: Container(
          width: c_width,
          child: ListView(
            children: <Widget>[
              Container(
                  width: c_width * 0.8,
                  padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
                  child: Wrap(
                    children: <Widget>[
                      Text(
                        data["Short Title"],
                        style: TextStyle(
                          fontSize: 30,
                          color: appColors.text,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
              Wrap(
                children: <Widget>[
                  HouseIconsWidget(billsMap: data, size: 40),
                  VotingStatusWidget(billsMap: data, voted: false, size: 40),
                ],
              ),
              Container(
                width: 1200,
                padding: EdgeInsets.all(20),
                child: Text(
                  data["Summary"],
                  style: TextStyle(fontSize: 20, color: appColors.text),
                ),
              ),
              BillInfoWidget(
                billText: data["text link pdf"],
                billEM: data["em link pdf"],
              ),
              PieWidget(
                yes: 1000,
                no: 551,
                radius: c_width,
              ),
              VoteWidget(
                data: data,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BillInfoWidget extends StatelessWidget {
  String billText;
  String billEM;
  BillInfoWidget({
    Key key,
    @required this.billText,
    @required this.billEM,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 1200,
        padding: EdgeInsets.all(10),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 5.0,
          color: appColors.card,
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
            child: Column(
              children: <Widget>[
                Text(
                  "Bill Information:",
                  style: TextStyle(
                      fontSize: 30,
                      color: appColors.text,
                      fontWeight: FontWeight.bold),
                ),
                Wrap(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[
                    Container(
                      width: 500,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(20),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  '/pdf',
                                  arguments: this.billText,
                                );
                              },
                              color: Colors.blue[900],
                              child: Text("View Bill Text",
                                  style: TextStyle(
                                      fontSize: 20, color: appColors.text)),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Text of the bill as introduced into the Parliament",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: appColors.text,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: 500,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(20),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  '/pdf',
                                  arguments: this.billEM,
                                );
                              },
                              color: Colors.purple[900],
                              child: Text("View Explanatory Memoranda",
                                  style: TextStyle(
                                      fontSize: 20, color: appColors.text)),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Explanatory Memorandum: Accompanies and provides an explanation of the content of the introduced version (first reading) of the bill.",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: appColors.text,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VoteWidget extends StatelessWidget {
  Map data;
  VoteWidget({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AreYouSure(String vote) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: appColors.card,
            title:
                Text('Confirm Vote', style: TextStyle(color: appColors.text)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure you want to vote ',
                      style: TextStyle(color: appColors.text)),
                  Text(vote + '?',
                      style: TextStyle(
                          color: appColors.text, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Confirm Vote'),
                onPressed: () {
                  // Put the vote on the blockchain!
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Center(
      child: Container(
        width: 1200,
        padding: EdgeInsets.all(10),
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            elevation: 5.0,
            color: appColors.card,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text("How would you like to vote on bill:",
                      style: TextStyle(fontSize: 16, color: appColors.text)),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(this.data["Short Title"],
                      style: TextStyle(
                          fontSize: 20,
                          color: appColors.text,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(50.0),
                          ),
                          onPressed: () {
                            AreYouSure("Yes");
                          },
                          padding: EdgeInsets.all(10),
                          color: Colors.green[900],
                          child: Text("Vote Yes",
                              style: TextStyle(
                                  fontSize: 20, color: appColors.text)),
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(50.0),
                          ),
                          onPressed: () {
                            AreYouSure("No");
                          },
                          padding: EdgeInsets.all(10),
                          color: Colors.red[900],
                          child: Text("Vote No",
                              style: TextStyle(
                                  fontSize: 20, color: appColors.text)),
                        ),
                      ],
                    )),
              ],
            )),
      ),
    );
  }
}
