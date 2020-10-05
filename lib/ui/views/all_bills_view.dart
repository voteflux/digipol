import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/viewmodels/all_bills_model.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/widgets/bill_list_item.dart';

class AllBillsPage extends StatefulWidget {
  @override
  _AllBillsPageState createState() => _AllBillsPageState();
}

TextEditingController _textController = TextEditingController();

class _AllBillsPageState extends State<AllBillsPage> {
  bool _lights = false;
  @override
  Widget build(BuildContext context) {
    return BaseView<BillsModel>(
      onModelReady: (model) => model.getBills(),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : CustomScrollView(
                  slivers: <Widget>[
                    SliverSafeArea(
                      top: false,
                      sliver: SliverAppBar(
                        automaticallyImplyLeading: false,
                        floating: true,
                        pinned: false,
                        stretch: true,
                        snap: true,
                        title: TextField(
                          controller: _textController,
                          onChanged: (value) {
                            model.searchBills(value);
                          },
                          decoration: InputDecoration(
                              icon: Icon(Icons.search),
                              hintText: "Search Bills",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    model.filteredbills.length > 0
                        ? SliverList(
                            key: ObjectKey(model.filteredbills),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return BillListItem(
                                    billData: model.filteredbills[index]);
                              },
                              childCount: model.filteredbills.length,
                            ),
                          )
                        : SliverList(
                            key: ObjectKey(model.filteredbills),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text('No bills found',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                );
                              },
                              childCount: 1,
                            ),
                          )
                  ],
                ),
          endDrawer: Drawer(
              child: Container(
            color: Theme.of(context).backgroundColor,
            child: ListView(
              children: <Widget>[
                // only voted switch
                SwitchListTile(
                  title: Text('Only voted'),
                  value: model.getOnlyVotedBills,
                  onChanged: (bool value) {
                    setState(() {
                      model.onlyVotedSearchSave(value);
                    });
                  },
                  secondary: Icon(Icons.done_outline,
                      color: Theme.of(context).iconTheme.color),
                ),
                // remove voted switch
                SwitchListTile(
                  title: Text('Remove voted'),
                  value: model.getRemoveVotedBills,
                  onChanged: (bool value) {
                    setState(() {
                      model.removeVotedSearchSave(value);
                    });
                  },
                  secondary: Icon(Icons.layers_clear,
                      color: Theme.of(context).iconTheme.color),
                ),
                // filter by date switch
                // SwitchListTile(
                //   title: Text('Sort by date'),
                //   value: model.getfilterByDate,
                //   onChanged: (bool value) {
                //     setState(() {
                //       model.filterByDateSave(value);
                //     });
                //   },
                //   secondary: Icon(Icons.date_range,
                //       color: Theme.of(context).iconTheme.color),
                // ),
                // filter by date switch
                SwitchListTile(
                  title: Text('Remove closed bills'),
                  value: model.getRemoveClosedBills,
                  onChanged: (bool value) {
                    setState(() {
                      model.removeClosedBillsFunction(value);
                    });
                  },
                  secondary: Icon(Icons.close,
                      color: Theme.of(context).iconTheme.color),
                )
              ],
            ),
          )),
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
