import 'package:flutter/material.dart';
import 'package:voting_app/route_generator.dart';
import 'package:voting_app/api/aus_bills.dart';

class AllIssuesPage extends StatelessWidget {
  List billsList = fetchBills();
  @override
  Widget build(BuildContext context) {
    List<Widget> billWidgetList = [];
    for (var i in billsList) {
      billWidgetList.add(BillWidget(i));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Routing App'),
      ),
      body: Center(
        child: ListView(
            children: billWidgetList,
        ),
      ),
    );
  }
}

class BillWidget extends StatelessWidget {
  Map billsMap;
  BillWidget(Map m){
    this.billsMap = m;
  }
  @override
  Widget build(BuildContext context) {
      return Center(
          child: Card(
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
                  width: 300,
                  height: 100,
                  child: Text(billsMap["Short Title"]),
                )
            )
          )
      );


  }
}
//billsMap["Short Title"]