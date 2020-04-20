import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/widgets/house_icon_widget.dart';
import 'package:voting_app/ui/widgets/pie_chart.dart';
import 'package:voting_app/ui/widgets/voting_status_widget.dart';
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: appColors.text),
        elevation: 0,
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
                showValues: true,
                no: bill.no,
                radius: dynamicMediumHeight,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0, top: 10.0, left: 20.0),
                child: HouseIconsWidget(bill: bill, size: 25),
              ),
              Container(
                width: dynamicLargeWidth,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0))),
                padding: EdgeInsets.all(appSizes.standardPadding),
                child: Column(
                  children: <Widget>[
                    Align(
                      child: VotingStatusWidget(
                          bill: bill, voted: false, size: 20),
                      alignment: Alignment.centerLeft,
                    ),
                    Align(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
                        child: Text(bill.shortTitle,
                            style: Theme.of(context).textTheme.headline5),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        bill.summary,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Divider(),
                    RaisedButton(
                      padding: EdgeInsets.all(20.0),
                      child: Text("View Bill Text"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PdfPage(pdfUrl: bill.textLinkPdf)),
                        );
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Text of the bill as introduced into the Parliament",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    RaisedButton(
                      child: Text("View Explanatory Memoranda"),
                      padding: EdgeInsets.all(20.0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PdfPage(pdfUrl: bill.emLinkPdf)),
                        );
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Accompanies and provides an explanation of the content of the introduced version (first reading) of the bill.",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ],
                ),
              ),
              VoteWidget(
                data: bill,
              ),
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
          margin: EdgeInsets.only(bottom: 20.0),
          child: Container(
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.all(appSizes.standardMargin),
            child: Column(
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    Container(
                      width: appSizes.smallWidth,
                      child: Column(
                        children: <Widget>[
                          RaisedButton(
                            child: Text("View Bill Text"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PdfPage(pdfUrl: this.billText)),
                              );
                            },
                          ),
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "Text of the bill as introduced into the Parliament",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: appSizes.smallWidth,
                      child: Column(
                        children: <Widget>[
                          RaisedButton(
                            child: Text("View Explanatory Memoranda"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PdfPage(pdfUrl: this.billEM)),
                              );
                            },
                          ),
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "Accompanies and provides an explanation of the content of the introduced version (first reading) of the bill.",
                              style: Theme.of(context).textTheme.bodyText2,
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
