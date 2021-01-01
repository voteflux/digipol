import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/viewmodels/all_bills_model.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'package:voting_app/ui/widgets/bill_list_item.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:voting_app/ui/widgets/topics_widget.dart';
import 'package:voting_app/core/funcs/convert_topic.dart';
import 'package:voting_app/core/consts.dart';

class AllBillsPage extends StatefulWidget {
  @override
  _AllBillsPageState createState() => _AllBillsPageState();
}

TextEditingController _textController = TextEditingController();

class _AllBillsPageState extends State<AllBillsPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<BillsModel>(
      onModelReady: (model) => model.getBills(),
      builder: (context, model, child) {
        print(model.filteredBills);
        return SafeArea(
          child: ValueListenableBuilder(
            valueListenable: model.billsBox.listenable(),
            builder: (context, Box<Bill> billsBox, widget) {
              return Scaffold(
                body: model.state == ViewState.Busy
                    ? Center(child: CircularProgressIndicator())
                    : CustomScrollView(
                        slivers: <Widget>[
                          SliverSafeArea(
                            top: false,
                            sliver: SliverAppBar(
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                              automaticallyImplyLeading: false,
                              floating: true,
                              pinned: false,
                              stretch: true,
                              snap: true,
                              bottom: PreferredSize(
                                preferredSize: Size.fromHeight(50.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                        child: Padding(
                                      padding:
                                          EdgeInsets.only(right: 4, left: 10),
                                      child: DropdownButton<String>(
                                        value: model.dropdownValue,
                                        dropdownColor:
                                            Theme.of(context).backgroundColor,
                                        underline: SizedBox.shrink(),
                                        icon: Icon(Icons.expand_more),
                                        iconSize: 24,
                                        elevation: 16,
                                        iconEnabledColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            model.dropDownFilter(newValue);
                                          });
                                        },
                                        items: DROPDOWN_FILTER_OPTIONS
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    )),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(right: 4, left: 4),
                                        child: Builder(
                                          builder: (context) =>
                                              RaisedButton.icon(
                                            onPressed: () =>
                                                Scaffold.of(context)
                                                    .openEndDrawer(),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            label: Text("Interests",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12)),
                                            icon: Icon(Icons.filter_list),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(right: 10, left: 4),
                                        child: Builder(
                                          builder: (context) =>
                                              OutlineButton.icon(
                                            splashColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            textColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                style: BorderStyle.solid,
                                                width: 1),
                                            onPressed: () =>
                                                Scaffold.of(context)
                                                    .openDrawer(),
                                            icon: Icon(
                                              Icons.unfold_more,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                            label: Text("Filters",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary)),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.search),
                                  tooltip: 'Add new entry',
                                  onPressed: () {/* ... */},
                                ),
                              ],
                              title: TextField(
                                controller: _textController,
                                onChanged: (value) {
                                  model.searchBills(value);
                                },
                                decoration: InputDecoration(
                                    hintText: "Search Bills",
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          SliverList(
                            key: ObjectKey(model.billList),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return model.billList.length > 0
                                    ? BillListItem(
                                        billData: model.billList[index])
                                    : Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text('No bills found',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6),
                                      );
                              },
                              childCount: max(1, model.billList.length),
                            ),
                          ),
                        ],
                      ),
                drawer: Drawer(
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          height: 60.0,
                          child: DrawerHeader(
                              child: Text('Filters',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                              margin: EdgeInsets.all(0),
                              padding:
                                  EdgeInsets.only(top: 10.0, bottom: 10.0)),
                        ),
                        Divider(),
                        Container(
                          height: 40.0,
                          child: DrawerHeader(
                              child: Text('Show only',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface)),
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.only(top: 10.0, bottom: 2.0)),
                        ),
                        SwitchListTile(
                          title: Text("Watched bills"),
                          value: model.getonlyWatchedBills,
                          onChanged: (bool value) {
                            setState(() {
                              model.savePrefInHive(value, USER_WATCHED_BILLS,
                                  model.showOnlyWatchedBills);
                            });
                          },
                        ),
                        // only voted switch
                        SwitchListTile(
                          title: Text("Bills I've voted on"),
                          value: model.getOnlyVotedBills,
                          onChanged: (bool value) {
                            setState(() {
                              model.savePrefInHive(
                                  value, ONLY_VOTED_BILLS, model.onlyVoted);
                            });
                          },
                        ),
                        // remove voted switch
                        SwitchListTile(
                          title: Text("Bills I've not voted on"),
                          value: model.getRemoveVotedBills,
                          onChanged: (bool value) {
                            setState(() {
                              model.savePrefInHive(
                                  value, REMOVE_VOTED_BILLS, model.removeVoted);
                            });
                          },
                        ),
                        SwitchListTile(
                          title: Text('Open bills'),
                          value: model.getRemoveClosedBills,
                          onChanged: (bool value) {
                            setState(() {
                              model.savePrefInHive(value, REMOVE_CLOSED_BILLS,
                                  model.removeClosedBillsFunction);
                            });
                          },
                        ),
                        SwitchListTile(
                          title: Text('Closed bills'),
                          value: model.getRemoveOpenBills,
                          onChanged: (bool value) {
                            setState(() {
                              model.savePrefInHive(value, REMOVE_OPEN_BILLS,
                                  model.removeOpenBillsFunction);
                            });
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: RaisedButton(
                            padding: EdgeInsets.only(
                                bottom: 8.0, top: 8.0, left: 10.0, right: 10.0),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Color(0xff898989),
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Show results',
                                  ),
                                  Icon(
                                    Icons.arrow_right_alt,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                endDrawer: Drawer(
                  child: Container(
                    padding: EdgeInsets.only(right: 8, left: 8),
                    color: Theme.of(context).backgroundColor,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          height: 60.0,
                          child: DrawerHeader(
                              child: Text('Interests',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                              margin: EdgeInsets.all(0),
                              padding:
                                  EdgeInsets.only(top: 10.0, bottom: 10.0)),
                        ),
                        Divider(),
                        Container(
                          height: 40.0,
                          child: DrawerHeader(
                              child: Text('Tags',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface)),
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.only(top: 10.0, bottom: 2.0)),
                        ),
                        TopicsWidget(
                          topics: ALL_TOPICS,
                          canPress: true,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: RaisedButton(
                            padding: EdgeInsets.only(
                                bottom: 8.0, top: 8.0, left: 10.0, right: 10.0),
                            onPressed: () {
                              model.refineByTopics();
                              Navigator.pop(context);
                            },
                            color: Color(0xff898989),
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Show results',
                                  ),
                                  Icon(
                                    Icons.arrow_right_alt,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
