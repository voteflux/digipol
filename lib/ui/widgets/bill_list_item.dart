import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/viewmodels/bill_model.dart';
import 'package:voting_app/locator.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/bills/bill_view.dart';
import 'package:voting_app/ui/widgets/house_icon_widget.dart';
import 'package:voting_app/ui/widgets/pie_chart.dart';
import 'package:voting_app/ui/widgets/voting_status_widget.dart';

class BillListItem extends StatefulWidget {
  @override
  _BillListItemState createState() => _BillListItemState();

  final Bill billData;
  final Map /*?*/ issuesMap;
  final Map<String, Color> billColors = {
    "House": appColors.house,
    "Senate": appColors.senate
  };
  final Map<String, String> billIntro = {
    "House": "Intro House",
    "Senate": "Intro Senate"
  };

  BillListItem({Key /*?*/ key, /*required*/ this.billData, this.issuesMap})
      : super(key: key);
}

class _BillListItemState extends State<BillListItem> {
  BillModel billModel = locator<BillModel>();
  /*late*/ String _vote;

  Future<void> getVote() async {
    var voteOpt = await billModel.hasVoted(widget.billData.id);
    voteOpt.map<void>((vote) => setState(() {
          this._vote = vote;
        }));
  }

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    getVote();
  }

  List<Widget> _buildTopicList(List<String> billTopics, BuildContext context) {
    List<Widget> topics = List.empty();
    billTopics.forEach((item) {
      topics.add(
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Chip(
              label: Text(item),
              labelStyle: Theme.of(context).textTheme.caption),
        ),
      );
    });
    return topics;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            Navigator.push<MaterialPageRoute>(
              context,
              MaterialPageRoute(
                builder: (context) => BillPage(
                  bill: widget.billData,
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(27.0),
            width: appSizes.mediumWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      VotingStatusWidget(
                          bill: widget.billData,
                          voted: _vote != null ? true : false,
                          size: 20),
                      Text(widget.billData.chamber,
                          style: Theme.of(context).textTheme.caption),
                      Text(widget.billData.startDate,
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Text(widget.billData.shortTitle,
                      style: Theme.of(context).textTheme.headline6),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    HouseIconsWidget(
                      bill: widget.billData,
                      size: 20,
                    ),
                    SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: PieWidget(
                        yes: widget.billData.yes,
                        showValues: false,
                        sectionSpace: 0,
                        no: widget.billData.no,
                        radius: 35,
                      ),
                    )
                  ],
                ),
                widget.billData.topics != null
                    ? Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        height: 30.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children:
                              _buildTopicList(widget.billData.topics, context),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(bottom: 0, top: 0),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
