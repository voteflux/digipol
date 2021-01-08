import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:voting_app/core/consts.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/viewmodels/bill_model.dart';
import 'package:voting_app/locator.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'package:voting_app/ui/views/bills/pdf_viewer.dart';
import 'package:voting_app/ui/widgets/house_icon_widget.dart';
import 'package:voting_app/ui/widgets/pie_chart.dart';
import 'package:voting_app/ui/widgets/topics_widget.dart';
import 'package:voting_app/ui/widgets/user_voted_status_widget.dart';
import 'package:voting_app/ui/widgets/voting_status_widget.dart';
import 'package:voting_app/ui/widgets/voting_widgets.dart';
import 'package:voting_app/ui/widgets/watch_bill_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class BillPage extends StatefulWidget {
  /* Not sure how we'd instantiate this. -MK
  */
  @override
  _BillPageState createState() => _BillPageState();
  /*
   */

  final Bill bill;

  BillPage({Key /*?*/ key, @required this.bill}) : super(key: key);
}

class _BillPageState extends State<BillPage> {
  BillModel billModel = locator<BillModel>();
  String /*?*/ _vote;
  Box<Bill> billsBox = Hive.box<Bill>(HIVE_BILLS);
  Box<BlockChainData> blockChainData =
      Hive.box<BlockChainData>(HIVE_BLOCKCHAIN_DATA);
  //late BlockChainData completeBlockChainData;
  BlockChainData completeBlockChainData;

  _BillPageState() {}

  Future getVote() async {
    /* do this in constructor  -MK
       (later) can't do this in the constructor, this.widget not defined. -MK
    // Get all bill data from Box
    List<BlockChainData> list = blockChainData.values
        .where((bill) => bill.id == widget.bill.id)
        .toList();
    completeBlockChainData = list[0];
     */
    print("this.completeBlockChainData: ${this.completeBlockChainData}");
    print("this.blockChainData: ${this.blockChainData}");
    print("start _BillPageState");
    this.completeBlockChainData = this
        .blockChainData
        .values
        .where((bill) => bill.id == this.widget.bill.id)
        .toList()
        .first;
    print("end _BillPageState");

    print("start getVote");
    var vote = await billModel.hasVoted(widget.bill.id);
    vote.map((v) => setState(() {
          _vote = v;
        }));
    print("end getVote");
  }

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    getVote();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BillModel>(
      onModelReady: (model) => model.getBill(widget.bill.id),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.onSurface),
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          title: Text('Back',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 14)),
        ),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Container(
                  margin: EdgeInsets.only(left: 14.0, right: 14.0),
                  child: ListView(
                    children: <Widget>[
                      Card(
                        margin: EdgeInsets.all(4.0),
                        child: Align(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(widget.bill.shortTitle,
                                style: Theme.of(context).textTheme.headline5),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            WatchBillWidget(id: widget.bill.id),
                            VotingStatusWidget(
                                bill: widget.bill,
                                voted: _vote != null ? true : false,
                                size: 20),
                            UserVotedStatus(
                                bill: widget.bill,
                                voted: _vote != null ? true : false,
                                size: 20)
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Align(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(bottom: 10.0, top: 10.0),
                                child: Text('About this bill',
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                widget.bill.summary,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            Align(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(bottom: 10.0, top: 20.0),
                                child: Text('Tags',
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            TopicsWidget(
                              topics: widget.bill.topics,
                              canPress: true,
                            ),
                            Align(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(bottom: 10.0, top: 20.0),
                                child: Text('More info',
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            RaisedButton(
                              padding: EdgeInsets.only(
                                  bottom: 8.0,
                                  top: 8.0,
                                  left: 10.0,
                                  right: 10.0),
                              onPressed: () {
                                launch(widget.bill.textLinkHtml);

//                                Navigator.push(
//                                  context,
//                                  MaterialPageRoute<PdfPage>(
//                                      builder: (context) => PdfPage(
//                                          pdfUrl: widget.bill.textLinkPdf)),
//                                );
                              },
                              color: Color(0xff898989),
                              child: Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'View Bill Text',
                                    ),
                                    Icon(
                                      Icons.arrow_right_alt,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10.0, top: 20.0),
                              child: Text(
                                "Text of the bill as introduced into the Parliament",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            RaisedButton(
                              padding: EdgeInsets.only(
                                  bottom: 8.0,
                                  top: 8.0,
                                  left: 10.0,
                                  right: 10.0),
                              onPressed: () {
                                launch(widget.bill.emLinkHtml);
//                                Navigator.push(
//                                  context,
//                                  MaterialPageRoute<PdfPage>(
//                                      builder: (context) => PdfPage(
//                                          pdfUrl: widget.bill.emLinkPdf)),
//                                );
                              },
                              color: Color(0xff898989),
                              child: Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'View Explanatory Memoranda',
                                    ),
                                    Icon(
                                      Icons.arrow_right_alt,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10.0, top: 20.0),
                              child: Text(
                                "Accompanies and provides an explanation of the content of the introduced version (first reading) of the bill.",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      VoteWidget(
                          data: completeBlockChainData.toBillChainData(),
                          vote: model.getVote,
                          yes: model.billVoteResult.yes,
                          no: model.billVoteResult.no),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
