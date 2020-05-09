import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/viewmodels/bill_model.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'package:voting_app/ui/widgets/house_icon_widget.dart';
import 'package:voting_app/ui/widgets/pie_chart.dart';
import 'package:voting_app/ui/widgets/voting_status_widget.dart';
import 'package:voting_app/ui/widgets/voting_widgets.dart';
import 'package:voting_app/ui/views/bills/pdf_viewer.dart';

class BillPage extends StatelessWidget {

  //NOTE: Not currently fetching from API, using parsed data from view above


  // information about the bill
  final String billId;

  BillPage({
    Key key,
    @required this.billId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dynamicMediumHeight = MediaQuery.of(context).size.height * 0.25;
    double dynamicLargeWidth = MediaQuery.of(context).size.width * 1;
    if (dynamicLargeWidth > appSizes.largeWidth) {
      dynamicLargeWidth = appSizes.largeWidth;
    }
    return BaseView<BillModel>(
      onModelReady: (model) => model.getBill(billId),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: appColors.text),
          elevation: 0,
          title: Text('Vote on Bill', style: appTextStyles.standard),
        ),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Container(
                  width: dynamicLargeWidth,
                  child: ListView(
                    children: <Widget>[
                      PieWidget(
                        yes: model.billVoteResult.yes,
                        showValues: true,
                        no: model.billVoteResult.no,
                        radius: dynamicMediumHeight,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 20.0, top: 10.0, left: 20.0),
                        child: HouseIconsWidget(bill: model.bill, size: 25),
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
                                  bill: model.bill, voted: false, size: 20),
                              alignment: Alignment.centerLeft,
                            ),
                            Align(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(bottom: 20.0, top: 10.0),
                                child: Text(model.bill.shortTitle,
                                    style:
                                        Theme.of(context).textTheme.headline5),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                model.bill.summary,
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
                                          PdfPage(pdfUrl: model.bill.textLinkPdf)),
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
                                          PdfPage(pdfUrl: model.bill.emLinkPdf)),
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
                        data: model.billChainData,
                        vote: model.getVote,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
