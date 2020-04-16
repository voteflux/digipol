import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/widgets/custom_widgets.dart';
import 'package:voting_app/ui/widgets/voting_widgets.dart';
import 'package:voting_app/ui/views/bills/pdf_viewer.dart';

class BillPage extends StatelessWidget {
  /// information about the bill
  final Bill bill;

  BillPage({
    Key key,
    @required this.bill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dynamicMediumHeight = MediaQuery.of(context).size.height * 0.25;
    double dynamicLargeWidth = MediaQuery.of(context).size.width * 1;
    if (dynamicLargeWidth > appSizes.largeWidth) {
      dynamicLargeWidth = appSizes.largeWidth;
    }
    return Scaffold(
      backgroundColor: appColors.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: appColors.text),
        elevation: 0,
        backgroundColor: appColors.background,
        title: Text('Vote on Bill', style: appTextStyles.standard),
      ),
      body: Center(
        child: Container(
          width: dynamicLargeWidth,
          child: ListView(
            children: <Widget>[
              PieWidget(
                // get from bill
                yes: bill.yes,
                no: bill.no,
                radius: dynamicMediumHeight,
              ),
              HouseIconsWidget(bill: bill, size: 25),
              Container(
                  width: dynamicLargeWidth,
                  color: appColors.backgroundSecondary,
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.all(appSizes.standardPadding),
                  child: Wrap(
                    children: <Widget>[
                      VotingStatusWidget(
                          bill: bill, voted: false, size: 30),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
                        child: Text(
                          bill.shortTitle,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: appColors.text),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          bill.summary,
                          style: appTextStyles.standard,
                        ),
                      ),
                      BillInfoWidget(
                        billText: bill.textLinkPdf,
                        billEM: bill.emLinkPdf,
                      ),
                      VoteWidget(
                        data: bill,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class BillInfoWidget extends StatelessWidget {
  /// Card directing voters to detailed info about the bill
  final billText;
  final billEM;
  BillInfoWidget({
    Key key,
    @required this.billText,
    @required this.billEM,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: appSizes.largeWidth,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(appSizes.cardCornerRadius)),
          elevation: appSizes.cardElevation,
          color: appColors.card,
          child: Container(
            padding: const EdgeInsets.all(5.0),
            margin: EdgeInsets.all(appSizes.standardMargin),
            child: Column(
              children: <Widget>[
                Wrap(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: appSizes.smallWidth,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minWidth: double.infinity),
                              child: FlatButton(
                                color: Colors.blue,
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  "View Bill Text",
                                  style: appTextStyles.yesnobutton,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PdfPage(pdfUrl: this.billText)),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Text of the bill as introduced into the Parliament",
                              style: appTextStyles.small,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: appSizes.smallWidth,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minWidth: double.infinity),
                              child: FlatButton(
                                color: Colors.blue,
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  "View Explanatory Memoranda",
                                  style: appTextStyles.yesnobutton,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PdfPage(pdfUrl: this.billEM)),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Accompanies and provides an explanation of the content of the introduced version (first reading) of the bill.",
                              style: appTextStyles.small,
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
