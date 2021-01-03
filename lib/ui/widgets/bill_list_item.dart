import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/viewmodels/bill_model.dart';
import 'package:voting_app/locator.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/bills/bill_view.dart';
import 'package:voting_app/ui/widgets/house_icon_widget.dart';
import 'package:voting_app/ui/widgets/pie_chart.dart';
import 'package:voting_app/ui/widgets/topics_widget.dart';
import 'package:voting_app/ui/widgets/voting_status_widget.dart';
import 'package:voting_app/ui/widgets/user_voted_status_widget.dart';

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

  BillListItem({Key /*?*/ key, @required this.billData, this.issuesMap})
      : super(key: key == null ? ObjectKey(billData) : key);
}

class _BillListItemState extends State<BillListItem> {
  BillModel billModel = locator<BillModel>();
  /*late*/ String _vote;

  Future<void> getVote() async {
    var voteOpt = await billModel.hasVoted(widget.billData.id);
    voteOpt.map<void>(
      (vote) => setState(() {
        this._vote = vote;
      }),
    );
  }

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    getVote();
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
            padding: EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Text(widget.billData.shortTitle,
                      style: Theme.of(context).textTheme.headline6),
                ),
                TopicsWidget(
                  topics: widget.billData.topics,
                  canPress: false,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    VotingStatusWidget(
                        bill: widget.billData,
                        voted: _vote != null ? true : false,
                        size: 20),
                    _vote != null
                        ? UserVotedStatus(
                            bill: widget.billData,
                            voted: _vote != null ? true : false,
                            size: 20)
                        : Padding(
                            padding: EdgeInsets.only(bottom: 10, top: 10),
                          ),
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
