import 'package:flutter/material.dart';
import 'package:voting_app/bill.dart';
import 'package:voting_app/api/aus_bills.dart';
import 'dart:math';
import 'package:voting_app/styles.dart';
import 'package:voting_app/custom_widgets.dart';
import 'dart:async';

class AllBillsPage extends StatefulWidget {
  @override
  _AllBillsPageState createState() => _AllBillsPageState();
}

class _AllBillsPageState extends State<AllBillsPage> {
  /// Where all the bills are shown (using ListView)
  var billsList = [];
  List<Widget> billWidgetList;
  @override
  Widget build(BuildContext context) {
    final Random random = new Random(); // To DELETE
    int billNum = billsList.length;
    billWidgetList = [
      CountUpWidget(number: billNum, text: "TOTAL BILLS"),
      BillsMessageWidget()
    ];
    for (var i in billsList) {
      billWidgetList.add(BillWidget(i));
    }

    Future<void> getBillsData() async {
//    var b = await fetchBills();
      var b = await fetchBillsDev(); // Change to non Dev when using api
      setState(() {
        billsList = b;
      });
    }

    loadedNotLoaded() {
      if (billNum == 0) {
        getBillsData();
        return Center();
      } else {
        return Center(
          child: ListView(
            controller: ScrollController(),
            children: billWidgetList,
          ),
        );
      }
    }

    return loadedNotLoaded();
  }
}

class BillWidget extends StatelessWidget {
  /// widget for the bill cards
  Map issuesMap;
  final Map billColors = {"House": appColors.house, "Senate": appColors.senate};
  final Map billIntro = {"House": "Intro House", "Senate": "Intro Senate"};
  // Delete Random when vote status is obtained
  final Random random = new Random();
  BillWidget(Map m) {
    this.issuesMap = m;
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(appSizes.cardCornerRadius),
        ),
        margin: EdgeInsets.all(appSizes.standardMargin),
        elevation: appSizes.cardElevation,
        color: appColors.card,
        child: InkWell(
          splashColor: appColors.cardInkWell,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BillPage(data: issuesMap)),
            );
          },
          child: Container(
            width: appSizes.mediumWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(appSizes.standardPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      VotingStatusWidget(
                          issuesMap: issuesMap,
                          // Delete Random when vote status is obtained
                          voted: random.nextInt(5) == 0,
                          size: 20),
                      Text(
                        issuesMap[billIntro[issuesMap["Chamber"]]],
                        // TextStyle specific to this widget
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 0, horizontal: appSizes.standardPadding),
                  child:
                      Text(issuesMap["Short Title"], style: appTextStyles.card),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    HouseIconsWidget(
                      issuesMap: issuesMap,
                      size: 20,
                    ),
                    PieWidget(
                      // Delete Random when vote status is obtained
                      yes: issuesMap["Yes"],
                      no: issuesMap["No"],
                      radius: 55,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BillsMessageWidget extends StatelessWidget {
  /// Card for showing a message at the top of the bills list
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(appSizes.cardCornerRadius),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: 0, vertical: appSizes.standardMargin),
        elevation: appSizes.cardElevation,
        color: appColors.card,
        child: Container(
          padding: EdgeInsets.all(appSizes.standardPadding),
          width: appSizes.smallWidth,
          child: Column(
            children: <Widget>[
              Text(
                "A list of all Federal Bills",
                style: appTextStyles.smallBold,
              ),
//                  Icon(Icons.subtitles, size: 80,color: appColors.text,),
              Container(
                height: 100,
                width: 100,
                child: Image(image: AssetImage('assets/graphics/point.png')),
              ),
              Text(
                "Vote on the Bills by scrolling and tapping on the Bills that matter most to you",
                style: appTextStyles.smallBold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
