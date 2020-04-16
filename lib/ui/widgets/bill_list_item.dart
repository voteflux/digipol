import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/ui/views/bills/bill.dart';
import 'dart:math';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/widgets/custom_widgets.dart';

class BillListItem extends StatelessWidget {
  final Bill bill;
  final Map issuesMap;
  final Map billColors = {"House": appColors.house, "Senate": appColors.senate};
  final Map billIntro = {"House": "Intro House", "Senate": "Intro Senate"};
  // Delete Random when vote status is obtained
  final Random random = new Random();

  BillListItem({this.bill, this.issuesMap});

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
              MaterialPageRoute(builder: (context) => BillPage(bill: bill)),
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
                      Text(
                        bill.chamber,
                        // TextStyle specific to this widget
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 0, horizontal: appSizes.standardPadding),
                  child: Text(
                    bill.shortTitle,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: appColors.text),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    HouseIconsWidget(
                      bill: bill,
                      size: 20,
                    ),
                    PieWidget(
                      // Delete Random when vote status is obtained
                      yes: bill.yes,
                      no: bill.no,
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
